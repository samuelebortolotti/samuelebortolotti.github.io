#!/usr/bin/env ruby
# frozen_string_literal: true

# ---------------------------------------------------------------------------
# update_publications.rb
#
# Keeps the `_publications/` Jekyll collection in sync with a DBLP profile.
#
#   * DBLP  (https://dblp.org/pid/<PID>.xml)  -> authoritative structured data
#     (author lists, venues, years, stable keys) + per-record BibTeX.
#   * arXiv (http://export.arxiv.org/api)      -> abstracts (DBLP has none).
#
# Design goals (in order):
#   1. Reliable    - one structured source, fetch-then-write (never leaves the
#                    repo half-updated), graceful degradation, retries.
#   2. Idempotent  - running it twice produces no diff.
#   3. Conservative - it never edits the prose/body of an existing entry and
#                    never deletes a file. By default it only creates missing
#                    entries and fills in *blank* front-matter fields.
#
# Usage:
#   ruby scripts/update_publications.rb [options]
#
#   --pid PID           DBLP person id            (default: 371/1046)
#   --check             dry run; exit 2 if the collection is out of date
#   --force             also overwrite authors / venue / BibTeX on existing
#                       entries from DBLP (implies --refresh-bibtex)
#   --only-new          only scaffold missing entries, touch nothing else
#   --no-preprints      skip records that only exist as arXiv/CoRR preprints
#   --with-datasets     also create entries for DBLP "data" (dataset) records
#   --no-promote        don't upgrade an entry whose venue still says
#                       "arXiv preprint" once DBLP shows it formally published
#   --no-abstract       don't call the arXiv API for abstracts
#   --no-annotate       don't add dblp_key / dblp_url to existing entries
#   --root DIR          site root                 (default: script's parent dir)
#   --sleep SECONDS     delay between DBLP requests (default: 1.0, be polite)
#   --verbose
#
# Exit codes: 0 ok / nothing to do, 2 out-of-date (only with --check), 1 error.
# ---------------------------------------------------------------------------

require "open-uri"
require "rexml/document"
require "optparse"
require "fileutils"
require "date"
require "time"

CONTACT   = "samuele.bortolotti@unitn.it"
USER_AGENT = "samuelebortolotti.github.io publications sync (mailto:#{CONTACT})"

OPTS = {
  pid:            "371/1046",
  check:          false,
  force:          false,
  only_new:       false,
  preprints:      true,
  datasets:       false,
  promote:        true,
  abstract:       true,
  annotate:       true,
  root:           File.expand_path("..", __dir__),
  sleep:          1.5,
  verbose:        false,
}

OptionParser.new do |o|
  o.on("--pid PID")        { |v| OPTS[:pid] = v }
  o.on("--check")          { OPTS[:check] = true }
  o.on("--force")          { OPTS[:force] = true }
  o.on("--only-new")       { OPTS[:only_new] = true }
  o.on("--no-preprints")   { OPTS[:preprints] = false }
  o.on("--with-datasets")  { OPTS[:datasets] = true }
  o.on("--no-promote")     { OPTS[:promote] = false }
  o.on("--no-abstract")    { OPTS[:abstract] = false }
  o.on("--no-annotate")    { OPTS[:annotate] = false }
  o.on("--root DIR")       { |v| OPTS[:root] = File.expand_path(v) }
  o.on("--sleep SECONDS")  { |v| OPTS[:sleep] = v.to_f }
  o.on("--verbose")        { OPTS[:verbose] = true }
end.parse!

PUB_DIR      = File.join(OPTS[:root], "_publications")
DATA_FILE    = File.join(OPTS[:root], "_data", "publications.yml")
IGNORE_FILE  = File.join(OPTS[:root], "scripts", "publications_ignore.txt")
PROFILE_URL  = "https://dblp.org/pid/#{OPTS[:pid]}"

STOPWORDS = %w[a an the of for and or to from with in on at by is are as new].freeze

# --------------------------------------------------------------------------
# small helpers
# --------------------------------------------------------------------------

def log(msg)  = warn(msg)
def vlog(msg) = (log(msg) if OPTS[:verbose])

def die(msg)
  log("ERROR: #{msg}")
  exit 1
end

# HTTP GET with retries and polite back-off. Returns the body string.
def http_get(url, tries: 4)
  attempt = 0
  begin
    attempt += 1
    URI.parse(url).open("User-Agent" => USER_AGENT, :read_timeout => 30, :open_timeout => 15, &:read)
  rescue OpenURI::HTTPError => e
    code = e.io.status[0].to_i
    retry_after = e.io.meta["retry-after"].to_i
    if [429, 500, 502, 503].include?(code) && attempt < tries
      wait = retry_after.positive? ? retry_after : 2**attempt
      log("  HTTP #{code} from #{url} - retrying in #{wait}s (#{attempt}/#{tries})")
      sleep wait
      retry
    end
    raise
  rescue SocketError, Net::OpenTimeout, Net::ReadTimeout, IOError, Errno::ECONNRESET => e
    if attempt < tries
      wait = 2**attempt
      log("  #{e.class} for #{url} - retrying in #{wait}s (#{attempt}/#{tries})")
      sleep wait
      retry
    end
    raise
  end
end

# Filename slug, mirroring the existing _publications/*.md naming:
# keep letters/digits/hyphens, collapse everything else to a single hyphen.
def slugify(title)
  title.strip
       .gsub(/[^\p{Alnum}\-]+/u, "-")
       .gsub(/-+/, "-")
       .gsub(/\A-|-\z/, "")
end

# Punctuation/whitespace/case-insensitive identity key used to match a DBLP
# record against an existing file and to collapse preprint/published pairs.
def title_key(title)
  title.downcase.gsub(/[^\p{Alnum}]+/u, " ").strip.squeeze(" ")
end

# Strip DBLP homonym disambiguation suffixes: "Jens Lehmann 0001" -> "Jens Lehmann".
def clean_author(name) = name.strip.sub(/\s+\d{4}\z/, "")

def yaml_quote(str)
  return str unless str.is_a?(String)
  if str.match?(/\A[\s>|@`%#*&!\[\]{}"',]/) || str.match?(/:\s|\s#|: \z|[:#]\z/) || str.include?('"')
    %("#{str.gsub('\\', '\\\\\\\\').gsub('"', '\\"')}")
  else
    str
  end
end

# --------------------------------------------------------------------------
# DBLP record model
# --------------------------------------------------------------------------

Record = Struct.new(:key, :type, :publtype, :title, :authors, :year, :month,
                    :venue, :pages, :ees, :mdate, keyword_init: true) do
  def preprint?  = publtype.to_s.include?("informal") || venue == "CoRR"
  def dataset?   = type == "data"
  def withdrawn? = publtype.to_s.include?("withdrawn")

  # lower is better when choosing a representative among same-title records
  def rank = dataset? ? 3 : (preprint? ? 2 : 0)

  def arxiv_id
    ees.each do |ee|
      case ee
      when %r{arxiv\.org/abs/([\w.\-]+?)(?:v\d+)?/?\z}i then return Regexp.last_match(1)
      when %r{10\.48550/arXiv\.([\w.\-]+)}i            then return Regexp.last_match(1)
      end
    end
    nil
  end

  MONTHS = %w[january february march april may june july august september october november december].freeze

  # DBLP almost never carries a month for conference papers, so fall back to the
  # month the venue is normally held. Used only when `month` is absent.
  CONF_MONTH = {
    "NeurIPS" => 12, "NIPS" => 12, "ICML" => 7, "ICLR" => 5, "UAI" => 7,
    "AAAI" => 2, "IJCAI" => 8, "IJCLR" => 9, "AISTATS" => 5, "KR" => 11,
    "ECAI" => 10, "COLT" => 6, "CVPR" => 6, "ICCV" => 10, "ECCV" => 10,
    "ACL" => 7, "EMNLP" => 11, "NAACL" => 6,
  }.freeze

  def month_num
    return nil unless month
    prefix = month.to_s.strip.downcase[0, 3]
    i = MONTHS.find_index { |m| m.start_with?(prefix) }
    i && i + 1
  end

  # Best-effort publication month: DBLP's own month, else the venue's usual
  # month, else January.
  def pub_month = month_num || CONF_MONTH[venue] || 1

  def approx_date = format("%04d-%02d-01", year.to_i, pub_month)

  VENUE_SHORT = {
    "CoRR"                    => "arXiv preprint",
    "J. Artif. Intell. Res."  => "JAIR",
  }.freeze

  def venue_label
    return "arXiv preprint" if preprint?
    short = VENUE_SHORT[venue] || venue
    "#{short} #{year}"
  end

  def venue_url(arxiv)
    return "https://arxiv.org/abs/#{arxiv}" if arxiv
    case venue
    when "NeurIPS" then "https://neurips.cc/Conferences/#{year}"
    when "UAI"     then "https://www.auai.org/uai#{year}/"
    when "ICML"    then "https://icml.cc/Conferences/#{year}"
    when "ICLR"    then "https://iclr.cc/Conferences/#{year}"
    when "AAAI"    then "https://aaai.org/conference/aaai/aaai-#{year}/"
    else best_ee || profile_fallback
    end
  end

  def profile_fallback = "https://dblp.org/rec/#{key}.html"

  # a "paper" link: prefer the formal open-access ee, fall back to arXiv/doi
  def best_ee(arxiv = arxiv_id)
    formal = ees.find { |e| e.match?(%r{papers?\.nips\.cc|proceedings\.mlr\.press|proceedings\.neurips\.cc|openreview\.net|aclanthology|dl\.acm\.org}i) }
    return formal if formal
    doi = ees.find { |e| e.match?(%r{doi\.org}i) && !e.match?(/arXiv/i) }
    return doi if doi
    return "https://arxiv.org/abs/#{arxiv}" if arxiv
    ees.first
  end

  def dblp_page = "https://dblp.org/rec/#{key}.html"

  def cite_key
    surname = clean_author(authors.first.to_s).split.last.to_s.downcase.gsub(/[^a-z]/, "")
    word = title.split(/\s+/).map { |w| w.downcase.gsub(/[^a-z0-9]/, "") }
               .find { |w| !w.empty? && !STOPWORDS.include?(w) } || "paper"
    "#{surname}#{year}#{word}"
  end
end

def parse_dblp(xml)
  doc = REXML::Document.new(xml)
  wanted = %w[article inproceedings incollection data]
  REXML::XPath.match(doc.root, "r/*").filter_map do |el|
    next unless wanted.include?(el.name)

    authors = REXML::XPath.match(el, "author").map { |a| clean_author(a.text.to_s) }
    ees     = REXML::XPath.match(el, "ee").sort_by { |e| e.attribute("type")&.value == "oa" ? 0 : 1 }
                          .map { |e| e.text.to_s.strip }
    rec = Record.new(
      key:      el.attribute("key")&.value,
      type:     el.name,
      publtype: el.attribute("publtype")&.value,
      title:    el.get_text("title").to_s.strip.sub(/\.\z/, ""),
      authors:  authors,
      year:     el.get_text("year").to_s.strip,
      month:    el.get_text("month")&.to_s&.strip,
      venue:    (el.get_text("booktitle") || el.get_text("journal")).to_s.strip,
      pages:    el.get_text("pages")&.to_s&.strip,
      ees:      ees,
      mdate:    el.attribute("mdate")&.value.to_s,
    )
    rec.withdrawn? ? nil : rec
  end
end

# Collapse preprint + published versions of the same paper into one record.
def dedup(records)
  records.group_by { |r| title_key(r.title) }.map do |_key, group|
    primary = group.min_by { |r| [r.rank, -r.year.to_i, r.mdate] }
    arxiv   = group.map(&:arxiv_id).compact.first
    [primary, arxiv, group]
  end
end

# --------------------------------------------------------------------------
# arXiv abstracts
# --------------------------------------------------------------------------

def arxiv_abstract(id)
  return nil unless id && OPTS[:abstract]
  vlog("  arXiv: fetching abstract for #{id}")
  body = http_get("http://export.arxiv.org/api/query?id_list=#{id}&max_results=1")
  m = body.match(%r{<summary>(.+?)</summary>}m) or return nil
  txt = m[1]
  txt = txt.gsub(/\s+/, " ").strip
  txt = txt.gsub("&amp;", "&").gsub("&lt;", "<").gsub("&gt;", ">")
  txt.empty? ? nil : txt
rescue StandardError => e
  log("  WARN: arXiv abstract fetch failed for #{id}: #{e.message}")
  nil
end

# --------------------------------------------------------------------------
# DBLP BibTeX
# --------------------------------------------------------------------------

def dblp_bibtex(rec)
  vlog("  DBLP: fetching BibTeX for #{rec.key}")
  raw = http_get("https://dblp.org/rec/#{rec.key}.bib?param=1")
  sleep OPTS[:sleep]
  raw = raw.gsub(/^\s*(timestamp|biburl|bibsource)\s*=.*\n/, "")
  raw = raw.sub(/\ADBLP:.*/, "") # no-op guard
  raw = raw.sub(/@(\w+)\{DBLP:[^,]+,/) { "@#{Regexp.last_match(1)}{#{rec.cite_key}," }
  raw = raw.sub(/,\s*\n\}\s*\z/, "\n}") # drop trailing comma before close
  raw.strip
rescue StandardError => e
  log("  WARN: DBLP BibTeX fetch failed for #{rec.key}: #{e.message}")
  nil
end

# --------------------------------------------------------------------------
# existing collection
# --------------------------------------------------------------------------

FrontMatter = Struct.new(:path, :yaml, :body, keyword_init: true) do
  def get(key)
    m = yaml.match(/^#{Regexp.escape(key)}:[ \t]*(.*)$/)
    return nil unless m
    v = m[1].strip
    v = v[1..-2] if v.start_with?('"') && v.end_with?('"')
    v.empty? ? nil : v
  end

  def has_list?(key) = yaml.match?(/^#{Regexp.escape(key)}:\s*\n\s+-\s/)
  def blank?(key)    = get(key).nil? && !has_list?(key)

  def set_scalar(key, value)
    line = "#{key}: #{yaml_quote(value)}"
    if yaml.match?(/^#{Regexp.escape(key)}:[ \t]*.*$/)
      # block form: never interpret backslashes in the replacement text
      self.yaml = yaml.sub(/^#{Regexp.escape(key)}:[ \t]*.*$/) { line }
    else
      self.yaml = yaml.rstrip + "\n" + line + "\n"
    end
  end

  def add_list(key, values)
    return if has_list?(key)
    block = "#{key}:\n" + values.map { |v| "  - #{yaml_quote(v)}" }.join("\n") + "\n"
    self.yaml = yaml.rstrip + "\n" + block
  end

  # Collapse repeated `key:` scalar lines down to the first occurrence.
  def dedupe_key(key)
    first = true
    self.yaml = yaml.gsub(/^#{Regexp.escape(key)}:[ \t].*\r?\n/) do |line|
      first ? (first = false; line) : ""
    end
  end

  def dup_scalar?(key) = yaml.scan(/^#{Regexp.escape(key)}:[ \t]/).size > 1

  def render = "---\n#{yaml.rstrip}\n---\n#{body}"
end

def load_front_matter(path)
  content = File.read(path)
  m = content.match(/\A---[ \t]*\r?\n(.*?\r?\n)---[ \t]*\r?\n(.*)\z/m) or return nil
  FrontMatter.new(path: path, yaml: m[1], body: m[2])
end

def load_existing
  index = {} # title_key / dblp_key  => FrontMatter
  Dir[File.join(PUB_DIR, "*.md")].sort.each do |path|
    fm = load_front_matter(path) or (log("  WARN: no front matter in #{path}, skipping") and next)
    if (t = fm.get("title"))
      index[title_key(t)] = fm
    end
    if (k = fm.get("dblp_key"))
      index[k] = fm
    end
  end
  index
end

def load_ignore
  return [] unless File.exist?(IGNORE_FILE)
  File.readlines(IGNORE_FILE, chomp: true)
      .map { |l| l.sub(/#.*/, "").strip }
      .reject(&:empty?)
end

# --------------------------------------------------------------------------
# scaffolding a new entry
# --------------------------------------------------------------------------

def scaffold(rec, arxiv, group)
  slug   = slugify(rec.title)
  paper  = rec.best_ee(arxiv)
  vurl   = rec.venue_url(arxiv)
  abstract = arxiv_abstract(arxiv) || "TODO: add the abstract for this publication."
  bibtex   = dblp_bibtex(rec) || "TODO: add a BibTeX entry (DBLP fetch failed)."
  extra_keys = group.map(&:key).uniq

  <<~MD
    ---
    layout: post
    permalink: /publications/#{slug}.html
    title: #{yaml_quote(rec.title)}
    date: #{rec.approx_date}
    redirect_from:
      - /en/publications/#{slug}.html
      - /it/publications/#{slug}.html
      - /de/publications/#{slug}.html
    ref: publications
    authors:
    #{rec.authors.map { |a| "  - #{yaml_quote(a)}" }.join("\n")}
    conference: #{yaml_quote(rec.venue_label)}
    conference_url: #{yaml_quote(vurl)}
    paper: #{yaml_quote(paper)}
    lang: en
    nav_bar: publications
    dblp_key: #{rec.key}
    dblp_url: #{rec.dblp_page}
    dblp_keys: #{extra_keys.join(", ")}
    ---

    # #{rec.title}

    ## Abstract

    #{abstract}

    ## How to cite

    ```
    #{bibtex}
    ```
  MD
end

# --------------------------------------------------------------------------
# main
# --------------------------------------------------------------------------

log("Fetching DBLP profile #{PROFILE_URL}.xml")
xml = begin
  http_get("#{PROFILE_URL}.xml")
rescue StandardError => e
  die("could not fetch DBLP profile: #{e.message}")
end
sleep OPTS[:sleep]

records = parse_dblp(xml)
die("parsed 0 records from DBLP - aborting without changes") if records.empty?
log("DBLP: #{records.size} raw records")

groups   = dedup(records)
existing = load_existing
ignore   = load_ignore

FileUtils.mkdir_p(PUB_DIR)
FileUtils.mkdir_p(File.dirname(DATA_FILE))

planned_creates  = []
planned_updates  = []
skipped          = []

groups.each do |rec, arxiv, group|
  tkey  = title_key(rec.title)
  match = existing[rec.key] || existing[tkey]

  reason_skip =
    if ignore.include?(rec.key) || ignore.include?(tkey) then "ignore list"
    elsif rec.dataset? && !OPTS[:datasets]               then "dataset (use --with-datasets)"
    elsif rec.preprint? && !OPTS[:preprints] && !match   then "preprint-only (use --preprints)"
    end

  if reason_skip && !match
    skipped << [rec.title, reason_skip]
    next
  end

  unless match
    planned_creates << [rec, arxiv, group]
    next
  end
  next if OPTS[:only_new]

  changes = []

  if OPTS[:annotate]
    changes << [:set, "dblp_key", rec.key] if match.get("dblp_key") != rec.key
    changes << [:set, "dblp_url", rec.dblp_page] if match.blank?("dblp_url")
    all_keys = group.map(&:key).uniq.join(", ")
    changes << [:set, "dblp_keys", all_keys] if group.size > 1 && match.get("dblp_keys") != all_keys
  end

  changes << [:set, "paper", rec.best_ee(arxiv)]        if match.blank?("paper")
  changes << [:set, "conference", rec.venue_label]      if match.blank?("conference")
  changes << [:set, "conference_url", rec.venue_url(arxiv)] if match.blank?("conference_url")
  changes << [:list, "authors", rec.authors]            if match.blank?("authors")

  # normalisation (deterministic, idempotent, safe on every run):
  #   * exactly one `ref: publications` (the language switcher keys off it)
  #   * `date` set to the venue month, not the arXiv-submission day
  if match.get("ref") != "publications"
    changes << [:set, "ref", "publications"]
    changes << [:dedupe, "ref"]
  elsif match.dup_scalar?("ref")
    changes << [:dedupe, "ref"]
  end
  unless rec.preprint?
    changes << [:set, "date", rec.approx_date] if match.get("date") != rec.approx_date
  end

  # promote a preprint entry once DBLP shows it formally published
  if OPTS[:promote] && !rec.preprint? &&
     match.get("conference").to_s.match?(/arxiv|preprint/i) &&
     match.get("conference") != rec.venue_label
    changes << [:set, "conference", rec.venue_label]
    changes << [:set, "conference_url", rec.venue_url(arxiv)]
    changes << [:set, "paper", rec.best_ee(arxiv)]
    changes << [:promoted]
  end

  if OPTS[:force]
    changes << [:list, "authors", rec.authors] unless match.get("authors") == rec.authors.join(", ")
    changes << [:set, "conference", rec.venue_label]
    changes << [:set, "paper", rec.best_ee(arxiv)]
    changes << [:bibtex]
  end

  planned_updates << [match, rec, arxiv, group, changes] unless changes.empty?
end

# ----- report --------------------------------------------------------------

log("")
log("Plan:")
if planned_creates.empty? && planned_updates.empty?
  log("  nothing to do - _publications/ is in sync with DBLP")
else
  planned_creates.each { |rec, *| log("  CREATE  #{slugify(rec.title)}.md  (#{rec.venue_label})") }
  planned_updates.each do |match, _rec, _a, _g, changes|
    fields = changes.map { |c| c[0] == :set || c[0] == :list ? c[1] : c[0].to_s }.uniq.join(", ")
    log("  UPDATE  #{File.basename(match.path)}  [#{fields}]")
  end
end
skipped.each { |title, why| log("  skip    #{title}  (#{why})") } if OPTS[:verbose]

# advisory only (renaming a published file would break its URL): flag entries
# whose filename no longer matches the slug of their title.
Dir[File.join(PUB_DIR, "*.md")].sort.each do |p|
  fm = load_front_matter(p) or next
  t  = fm.get("title") or next
  want = slugify(t)
  have = File.basename(p, ".md")
  log("  WARN    #{have}.md: filename does not match title slug (#{want}.md)") if want != have
end

# ----- check mode --------------------------------------------------------------

if OPTS[:check]
  out_of_date = !(planned_creates.empty? && planned_updates.empty?)
  log("")
  log(out_of_date ? "OUT OF DATE - run `rake publications`" : "up to date")
  exit(out_of_date ? 2 : 0)
end

# ----- apply --------------------------------------------------------------

planned_updates.each do |match, rec, arxiv, group, changes|
  changes.each do |kind, key, val|
    case kind
    when :set    then match.set_scalar(key, val)
    when :list   then match.add_list(key, val)
    when :dedupe then match.dedupe_key(key)
    when :bibtex
      if (bib = dblp_bibtex(rec))
        # block form: `bib` may contain \', \_, \\ (valid BibTeX/TeX) which a
        # string replacement would otherwise treat as back-references.
        replaced = match.body.sub(/(##\s*How to cite\s*\n+```\n).*?\n(```)/m) do
          "#{Regexp.last_match(1)}#{bib}\n#{Regexp.last_match(2)}"
        end
        if replaced == match.body
          log("  WARN: could not locate a BibTeX block in #{File.basename(match.path)} - left as is")
        else
          match.body = replaced
        end
      end
    end
  end
  File.write(match.path, match.render)
  log("  wrote   #{File.basename(match.path)}")
end

planned_creates.each do |rec, arxiv, group|
  path = File.join(PUB_DIR, "#{slugify(rec.title)}.md")
  File.write(path, scaffold(rec, arxiv, group))
  log("  wrote   #{File.basename(path)}")
  log("          ^ review the Abstract" ) if arxiv.nil? || !OPTS[:abstract]
end

# ----- data file --------------------------------------------------------------

count = Dir[File.join(PUB_DIR, "*.md")].size
now   = Time.now.utc
File.write(DATA_FILE, <<~YAML)
  # Auto-generated by scripts/update_publications.rb - DO NOT EDIT BY HAND.
  # Regenerate with:  rake publications
  last_updated: #{now.strftime("%Y-%m-%d")}
  last_updated_iso: #{now.iso8601}
  source: #{PROFILE_URL}
  source_name: DBLP
  pid: "#{OPTS[:pid]}"
  count: #{count}
  generator: scripts/update_publications.rb
YAML
log("")
log("Wrote #{DATA_FILE.sub(OPTS[:root] + '/', '')}  (last_updated: #{now.strftime('%Y-%m-%d')}, count: #{count})")
log("Done.")
