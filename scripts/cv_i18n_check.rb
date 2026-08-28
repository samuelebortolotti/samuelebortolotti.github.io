#!/usr/bin/env ruby
# frozen_string_literal: true

# ---------------------------------------------------------------------------
# cv_i18n_check.rb
#
# Cross-checks _data/cv_i18n.yml against _data/cv.yml: reports translation keys
# that no longer match any English string in the CV (stale), and English strings
# that have no translation (missing). Proper-noun fields (institutions, talk /
# paper titles, venues, people, locations, dates) are not expected to be
# translated and are ignored.
#
#   ruby scripts/cv_i18n_check.rb [--check]
#
#   --check   exit 2 if anything is stale or missing (for CI / pre-commit)
# ---------------------------------------------------------------------------

require "yaml"

ROOT = File.expand_path("..", __dir__)
cv   = YAML.load_file(File.join(ROOT, "_data", "cv.yml"))
i18n = YAML.load_file(File.join(ROOT, "_data", "cv_i18n.yml"))

# strings the resume template runs through the translation table
translatable = []
%w[education experience teaching talks training].each do |sec|
  (cv[sec] || []).each do |e|
    translatable << e["position"]
    translatable.concat(Array(e["items"]))
  end
end
(cv["collaborations"] || []).each { |c| translatable << c["area"] }
(cv["skills"] || []).each { |s| translatable << s["category"] << s["skills"] }
(cv["honors"] || []).each { |h| translatable << h["award"] << h["event"] }
translatable = translatable.compact.uniq
keep = Array(i18n["keep"])

problems = 0
%w[it de].each do |lang|
  table = i18n[lang] || {}
  missing = translatable - table.keys - keep
  stale   = table.keys - translatable
  missing.each { |s| warn "  [#{lang}] missing translation: #{s.inspect}" }
  stale.each   { |s| warn "  [#{lang}] stale key (not in cv.yml): #{s.inspect}" }
  problems += missing.size + stale.size
end

if problems.zero?
  puts "cv_i18n.yml: in sync with cv.yml (#{translatable.size} strings x it/de)"
  exit 0
end

warn ""
warn "#{problems} issue(s). Edit _data/cv_i18n.yml."
exit(ARGV.include?("--check") ? 2 : 0)
