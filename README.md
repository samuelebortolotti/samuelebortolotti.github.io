# Samuele Bortolotti's web site

My personal web site made with [Jekyll](https://jekyllrb.com/) and hosted with [GitHub Pages](https://pages.github.com/).

The site is static, has no external CSS/JS and makes no third-party requests. The
only JavaScript is [MathJax](https://www.mathjax.org/) 3, **self-hosted** in
[`assets/js/mathjax/`](assets/js/mathjax/) and loaded only on pages with
`mathjax: true` in their front matter.

Content lives in three languages (`en/`, `it/`, `de/`): About, News, Publications
and a short Résumé. Two generated data files drive parts of it:

* [`_data/publications.yml`](_data/publications.yml) — sync stamp for the
  Publications page (see below); **do not edit by hand**.
* [`_data/news.yml`](_data/news.yml) — hand-maintained news feed shown on the
  home page, on `/news`, and as the RSS feed at `/feed.xml`
  ([`_includes/all_feed.xml`](_includes/all_feed.xml), regenerated on every
  build). Newest first; each entry has a `date` and `en` / `it` / `de` text plus
  an optional `url`. Keep the three languages in sync.

## Local setup

Install [Ruby](https://www.ruby-lang.org/en/) (once):

```bash
make install-ruby   # latest Ruby via rbenv
bundle install      # or: make install
```

The CV also needs a TeX distribution with XeLaTeX + Biber (TeX Live, MacTeX, …).

```bash
make help           # list every Makefile target
rake -T             # list every Rake task
```

## Updating the site

Everything below is a normal edit-commit-push; GitHub Pages rebuilds `master`
automatically. Run `make serve` (→ <http://127.0.0.1:4000>) to preview first.

### Content and translations

Pages live under `en/`, `it/`, `de/` (About = `index.md`, plus `news.md`,
`publications.md`, `resume.md`). **Every user-facing change must be made in all
three languages.** Shared chrome is in [`_includes/`](_includes/)
(`sidebar.html`, `head.html`) and [`_layouts/default.html`](_layouts/default.html);
styles in [`assets/css/style.css`](assets/css/style.css) (one file, no build step).

### News

Edit [`_data/news.yml`](_data/news.yml). Add a block (order is not important — it
is sorted by `date`):

```yaml
- date: 2026-09-15
  url: /publications/Something.html   # optional: local path or full https:// URL
  en: '...'
  it: '...'
  de: '...'
```

The text is Markdown: `**bold**` the paper title, `_emph_` a talk title, link
the venue / school / person, end a milestone with `!`, no emojis. For a paper,
add one entry when the preprint goes up and one when it is accepted / published.

That one file feeds the home-page section, `/news`, and the RSS feed at
`/feed.xml` ([`_includes/all_feed.xml`](_includes/all_feed.xml)), all regenerated
on every build. It is deliberately manual: the three languages cannot be
auto-translated, and talks / visits / awards are not in any machine-readable
source.

### Publications

```bash
rake publications          # create missing entries, fill blank fields,
                           # normalise ref/date, refresh _data/publications.yml
rake publications:check    # dry run; non-zero exit if the collection is stale
rake publications:refresh  # also overwrite authors / venue / BibTeX from DBLP
rake publications:new      # only scaffold entries that don't have a file yet
```

After a run, review any new `_publications/*.md` (abstract, links), commit, and
regenerate the CV bibliography (`rake cv:bib`, or just `make cv`). What the
sync script does, and why it is safe to run often:

* **Source of truth is DBLP** (structured XML + per-record BibTeX); abstracts are
  pulled from the **arXiv API** when a record has an arXiv link, otherwise a
  `TODO` is left for me to fill in.
* It **never edits the prose/body** of an existing entry and **never deletes** a
  file. By default it creates missing entries, fills *blank* front-matter fields,
  and applies a few deterministic normalisations: a single `ref: publications`
  (the language switcher keys off it) and a `date` set to the venue month
  (`CONF_MONTH` in the script), not the arXiv-submission day. It also adds
  `dblp_key` so future runs match exactly, and warns (without renaming) if a
  file name no longer matches the slug of its title.
* Preprint + published versions of the same paper are **collapsed into one**
  entry, preferring the formal version. An entry whose venue still reads
  `arXiv preprint` is **promoted** once DBLP shows it formally published.
* It is **idempotent** — running it twice produces no diff — and it fetches
  everything before writing, so a network failure never leaves the repo
  half-updated.
* Records I don't want as their own page go in
  [`scripts/publications_ignore.txt`](scripts/publications_ignore.txt).

Options: `DBLP_PID=<id> rake publications`, or
`ARGS="--no-abstract --verbose" rake publications`. Every flag is documented in
the comment header of [`scripts/update_publications.rb`](scripts/update_publications.rb).
The Publications page (`en`, `it`, `de`) shows the last sync date and entry
count, read from `_data/publications.yml`.

### CV

The CV is an [Awesome-CV](https://github.com/posquit0/Awesome-CV) document under
[`cv/`](cv/) (`samuele_bortolotti_cv.tex` + `awesome-cv.cls` + `fonts/`). **The
`.tex` is the single source.** Two generated artefacts hang off it:

* [`cv/resume/references.bib`](cv/resume/references.bib) — the bibliography,
  built from the `_publications/*.md` "How to cite" blocks by
  [`scripts/gen_bib.rb`](scripts/gen_bib.rb), so the CV and the website cite one
  source. BibTeX keys must match the `\nocite{...}` calls in the `.tex`.
* [`_data/cv.yml`](_data/cv.yml) — the résumé pages (`en/it/de/resume.md`) render
  from this, parsed out of the `.tex` by
  [`scripts/cv_to_yaml.rb`](scripts/cv_to_yaml.rb). Section headings are
  localised via [`_data/resume_labels.yml`](_data/resume_labels.yml); entry text
  is translated via [`_data/cv_i18n.yml`](_data/cv_i18n.yml) (keyed by the
  English string, English fallback). Proper nouns — institutions, lab / talk /
  paper titles, venues, people — stay English.

```bash
make cv             # gen_bib + cv_to_yaml + i18n check + xelatex/biber -> files/…cv.pdf
rake cv:bib         # only regenerate cv/resume/references.bib
rake cv:sync        # only regenerate _data/cv.yml
rake cv:check       # dry run; fail if references.bib is stale
rake cv:sync:check  # dry run; fail if _data/cv.yml is stale
rake cv:i18n:check  # dry run; fail if it/de translations are missing or stale
make cv-clean       # remove LaTeX build artefacts under cv/
```

Workflow: edit `cv/*.tex`, run `make cv`, **eyeball the `_data/cv.yml` diff**
(the parser only understands this CV's structure) and any `cv_i18n` warnings
(new English strings need an `it`/`de` line), then commit `cv/*.tex`,
`_data/cv.yml`, `_data/cv_i18n.yml`, and the refreshed
`files/bortolotti_samuele_cv.pdf` (the sidebar links to it). LaTeX build
artefacts under `cv/` are git-ignored.

## Monthly sync (GitHub Actions)

[`.github/workflows/monthly-sync.yml`](.github/workflows/monthly-sync.yml) runs
on the 1st of each month (and on demand from the Actions tab):

1. `rake publications` — pull new entries from DBLP.
2. `rake cv:bib` + `rake cv:sync` — refresh `references.bib` and `_data/cv.yml`.
3. **Recompile the CV only if `references.bib` changed** (i.e. a new
   publication); otherwise the TeX step is skipped.
4. Open a pull request with whatever changed — nothing changed means no PR.

Review the PR before merging: watch for `TODO` abstracts in new
`_publications/*.md`, check the `_data/cv.yml` diff, and add `it`/`de` lines to
`_data/cv_i18n.yml` for any new résumé strings (`rake cv:i18n:check` lists them).
News is **not** touched by the workflow.

For the PR step to work, in **Settings → Actions → General → Workflow
permissions** enable *Read and write permissions* and *Allow GitHub Actions to
create and approve pull requests*. The CV source under `cv/` must stay tracked
(only build artefacts are git-ignored) so the workflow can rebuild it.

## Deploy

Push (or merge) to `master`. GitHub Pages builds the site with the
`github-pages` gem (`jekyll-seo-tag`, `jekyll-sitemap`, `jekyll-redirect-from`).
`rake publications:check`, `rake cv:check`, `rake cv:sync:check`,
`rake cv:i18n:check` are available for a pre-commit hook if wanted.