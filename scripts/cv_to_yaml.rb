#!/usr/bin/env ruby
# frozen_string_literal: true

# ---------------------------------------------------------------------------
# cv_to_yaml.rb
#
# Parses the Awesome-CV source (cv/samuele_bortolotti_cv.tex) into
# _data/cv.yml, which the resume pages (en/it/de) render from. This keeps the
# website resume in sync with the LaTeX CV.
#
#   ruby scripts/cv_to_yaml.rb [--tex PATH] [--out PATH] [--check]
#
#   --tex PATH   the .tex source     (default: cv/samuele_bortolotti_cv.tex)
#   --out PATH   the .yml to write   (default: _data/cv.yml)
#   --check      don't write; exit 2 if _data/cv.yml is out of date
#
# It only understands the structure of THIS CV (\cvsection / \cventry /
# \cvhonor / \cvskill / cvitems). After a CV edit, run it and eyeball the diff.
#
# Exit codes: 0 ok / 2 out-of-date (with --check) / 1 error.
# ---------------------------------------------------------------------------

require "optparse"
require "yaml"

ROOT = File.expand_path("..", __dir__)
opts = {
  tex:   File.join(ROOT, "cv", "samuele_bortolotti_cv.tex"),
  out:   File.join(ROOT, "_data", "cv.yml"),
  check: false,
}
OptionParser.new do |o|
  o.on("--tex PATH") { |v| opts[:tex] = File.expand_path(v) }
  o.on("--out PATH") { |v| opts[:out] = File.expand_path(v) }
  o.on("--check")    { opts[:check] = true }
end.parse!

SRC = File.read(opts[:tex])

# --- tiny helpers ----------------------------------------------------------

# strip TeX comments (a real % , not \%)
def decomment(str)
  str.gsub(/(?<!\\)%.*$/, "")
end

# from index `i` (which must sit on the opening "{"), return [content, index_after_close]
def balanced(str, i)
  depth = 0
  start = i
  while i < str.length
    c = str[i]
    if c == "{" && str[i - 1] != "\\"
      depth += 1
    elsif c == "}" && str[i - 1] != "\\"
      depth -= 1
      return [str[start + 1...i], i + 1] if depth.zero?
    end
    i += 1
  end
  [str[start + 1..], str.length]
end

# read the next `n` brace groups starting at/after index `i`; returns [groups, index_after]
def brace_args(str, i, n)
  groups = []
  n.times do
    i += 1 while i < str.length && str[i] != "{"
    break if i >= str.length
    g, i = balanced(str, i)
    groups << g
  end
  [groups, i]
end

# LaTeX inline -> Markdown/plain, good enough for CV prose
def inline(tex)
  s = tex.dup
  # \href{url}{text}  (text may nest braces)
  loop do
    m = s.match(/\\href\s*\{/) or break
    url, after = balanced(s, m.end(0) - 1)
    after += 1 while after < s.length && s[after] =~ /\s/
    if s[after] == "{"
      txt, aend = balanced(s, after)
      s = s[0...m.begin(0)] + "[#{inline(txt)}](#{url.strip})" + s[aend..]
    else
      s = s[0...m.begin(0)] + inline(url) + s[after..]
    end
  end
  s = s.gsub(/\\textbf\s*\{([^{}]*)\}/) { "**#{Regexp.last_match(1).strip}**" }
  s = s.gsub(/\\(?:emph|textit|em)\s*\{([^{}]*)\}/) { "_#{Regexp.last_match(1).strip}_" }
  s = s.gsub(/\\entrydatestyle\s*\{([^{}]*)\}/) { Regexp.last_match(1) }
  s = s.gsub(/\\begin\{minipage\}(?:\[[^\]]*\])?\s*\{[^{}]*\}/, "")
  s = s.gsub(/\\end\{minipage\}/, "")
  s = s.gsub(/\\hfill\s*/, " — ")
  s = s.gsub(/\\newline\s*/, " ")
  s = s.gsub(/\\\\\s*/, "\n")            # LaTeX line break -> newline
  s = s.gsub(/\\([#&%_$])/, '\1')
  s = s.gsub(/\{\}|\\,|\\!/, "")
  s = s.split("\n").map { |ln| ln.gsub(/\s+/, " ").strip }.reject(&:empty?).join("\n")
  s
end

# pull \item {..} entries out of a cvitems block
def items(desc)
  return [] unless desc =~ /\\begin\{cvitems\}(.*?)\\end\{cvitems\}/m
  body = Regexp.last_match(1)
  out = []
  i = 0
  while (m = body.match(/\\item\b\s*\{/, i))
    txt, i = balanced(body, m.end(0) - 1)
    eol = body.index("\n", i) || body.length
    trailing = body[i...eol].strip           # e.g. "\hfill2025, 2026"
    txt = "#{txt} #{trailing}" unless trailing.empty?
    out << inline(txt)
    i = eol
  end
  out
end

# --- section slicing -----------------------------------------------------------

text = decomment(SRC)
marks = text.enum_for(:scan, /\\cvsection\s*\{/).map { Regexp.last_match.begin(0) }
sections = {}
marks.each_with_index do |start, idx|
  name_groups, after = brace_args(text, start + "\\cvsection".length, 1)
  name = inline(name_groups.first)
  stop = marks[idx + 1] || text.length
  sections[name] = text[after...stop]
end

def entries(block)
  out = []
  i = 0
  while (m = block.match(/\\cventry\b/, i))
    args, i = brace_args(block, m.end(0), 5)
    a, b, c, d, e = args
    out << {
      "position" => inline(a),
      "title"    => inline(b),
      "location" => inline(c),
      "date"     => inline(d),
      "items"    => items(e),
    }
  end
  out
end

def honors(block)
  out = []
  i = 0
  while (m = block.match(/\\cvhonor\b/, i))
    args, i = brace_args(block, m.end(0), 4)
    a, b, c, d = args
    out << {
      "award"    => inline(a),
      "event"    => inline(b),
      "location" => inline(c),
      "date"     => inline(d),
    }
  end
  out
end

def skills(block)
  out = []
  i = 0
  while (m = block.match(/\\cvskill\b/, i))
    args, i = brace_args(block, m.end(0), 2)
    out << { "category" => inline(args[0]), "skills" => inline(args[1]) }
  end
  out
end

def clean_entries(list)
  list.map do |e|
    e = e.reject { |_, v| v.nil? || (v.respond_to?(:empty?) && v.empty?) }
    e.delete("items") if e["items"].nil? || e["items"].empty?
    e
  end
end

data = {
  "_generated_from" => "cv/samuele_bortolotti_cv.tex",
  "_regenerate"     => "rake cv:sync",
}
data["position"] = (SRC[/\\position\{([^}]*)\}/, 1] || "").strip
sections.each do |name, block|
  key =
    case name
    when /Education/i               then "education"
    when /Work Experience/i         then "experience"
    when /Teaching/i                then "teaching"
    when /Talks/i                   then "talks"
    when /Collaborations/i          then "collaborations"
    when /Reviewing/i               then "reviewing"
    when /Extracurricular|Training/i then "training"
    when /Skills/i                  then "skills"
    when /Honors|Awards/i           then "honors"
    when /Publications/i            then next # rendered from _data/publications.yml + the publications page
    else name.downcase.gsub(/[^a-z0-9]+/, "_")
    end
  data[key] =
    case key
    when "honors" then honors(block)
    when "skills" then skills(block)
    else clean_entries(entries(block))
    end
end

# --- section-specific shaping ------------------------------------------------

# collaborations: {position: people-blob, title: area} -> {area, people}
if data["collaborations"]
  data["collaborations"] = data["collaborations"].map do |e|
    { "area" => e["title"], "people" => e["position"].to_s.split("\n").map(&:strip).reject(&:empty?) }
  end
end

# reviewing: one \cventry whose cvitems are the venues -> flat list
if data["reviewing"]
  data["reviewing"] = data["reviewing"].flat_map { |e| e["items"] || [] }
end

rendered = data.to_yaml(line_width: -1)

if opts[:check]
  current = File.exist?(opts[:out]) ? File.read(opts[:out]) : ""
  if current == rendered
    puts "up to date: #{opts[:out].sub(ROOT + '/', '')}"
    exit 0
  end
  warn "OUT OF DATE: #{opts[:out].sub(ROOT + '/', '')} - run `rake cv:sync` and review the diff"
  exit 2
end

require "fileutils"
FileUtils.mkdir_p(File.dirname(opts[:out]))
File.write(opts[:out], rendered)
puts "wrote #{opts[:out].sub(ROOT + '/', '')}"
data.each { |k, v| puts "  #{k}: #{v.is_a?(Array) ? "#{v.size} entries" : v.inspect}" unless k.start_with?("_") }
