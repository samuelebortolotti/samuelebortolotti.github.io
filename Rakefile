# frozen_string_literal: true
#
# Task runner for samuelebortolotti.github.io.
#
#   rake publications          sync _publications/ from DBLP (safe default:
#                              create missing entries, fill blank fields,
#                              refresh _data/publications.yml)
#   rake publications:check    dry run; fails if the collection is out of date
#                              (use in CI / pre-commit)
#   rake publications:refresh  also overwrite authors / venue / BibTeX on
#                              existing entries from DBLP
#   rake publications:new      only scaffold entries that don't exist yet
#
#   rake build                 bundle exec jekyll build
#   rake serve                 bundle exec jekyll serve --watch
#
# Config via env vars:
#   DBLP_PID   DBLP person id             (default 371/1046)
#   ARGS       extra flags passed straight through to the script
#
# The sync script only needs the Ruby standard library, so `rake publications`
# works with or without `bundle exec`.

DBLP_PID = ENV.fetch("DBLP_PID", "371/1046")
SYNC     = ["ruby", File.join(__dir__, "scripts", "update_publications.rb"), "--pid", DBLP_PID]
EXTRA    = ENV.fetch("ARGS", "").split

def sync(*flags) = sh(*SYNC, *flags, *EXTRA)

desc "Sync _publications/ from DBLP (create missing, fill blanks, stamp the date)"
task :publications do
  sync
end

namespace :publications do
  desc "Dry run: report drift and exit non-zero if _publications/ is out of date"
  task :check do
    sync "--check"
  end

  desc "Sync and also overwrite authors / venue / BibTeX on existing entries"
  task :refresh do
    sync "--force"
  end

  desc "Only scaffold publications that do not have a file yet"
  task :new do
    sync "--only-new"
  end
end

GEN_BIB     = ["ruby", File.join(__dir__, "scripts", "gen_bib.rb")].freeze
CV_TO_YAML  = ["ruby", File.join(__dir__, "scripts", "cv_to_yaml.rb")].freeze
CV_I18N_CHK = ["ruby", File.join(__dir__, "scripts", "cv_i18n_check.rb")].freeze
CV_PDF      = File.join(__dir__, "files", "bortolotti_samuele_cv.pdf")

namespace :cv do
  desc "Regenerate cv/resume/references.bib from _publications/*.md"
  task :bib do
    sh(*GEN_BIB)
  end

  desc "Regenerate _data/cv.yml from the .tex (drives the resume pages)"
  task :sync do
    sh(*CV_TO_YAML)
  end

  namespace :sync do
    desc "Dry run: fail if _data/cv.yml is out of date"
    task :check do
      sh(*CV_TO_YAML, "--check")
    end
  end

  desc "Check _data/cv_i18n.yml (it/de resume translations) against cv.yml"
  task :i18n do
    sh(*CV_I18N_CHK)
  end

  namespace :i18n do
    desc "Dry run: fail if translations are missing or stale"
    task :check do
      sh(*CV_I18N_CHK, "--check")
    end
  end

  desc "Dry run: fail if cv/resume/references.bib is out of date"
  task :check do
    sh(*GEN_BIB, "--check")
  end

  desc "Remove LaTeX build artefacts under cv/"
  task :clean do
    Dir.chdir(File.join(__dir__, "cv")) { sh "latexmk", "-C" }
  end
end

desc "Regenerate references.bib + cv.yml and compile the CV to files/bortolotti_samuele_cv.pdf"
task cv: ["cv:bib", "cv:sync", "cv:i18n"] do
  Dir.chdir(File.join(__dir__, "cv")) do
    sh "latexmk", "-xelatex", "-interaction=nonstopmode", "-halt-on-error", "samuele_bortolotti_cv.tex"
    cp "samuele_bortolotti_cv.pdf", CV_PDF
    sh "latexmk", "-c"
  end
end

desc "Build the Jekyll site"
task :build do
  sh "bundle", "exec", "jekyll", "build"
end

desc "Serve the Jekyll site locally with live reload"
task :serve do
  sh "bundle", "exec", "jekyll", "serve", "--watch"
end

task default: "publications:check"
