# Samuele Bortolotti's web site

My personal web site made with [Jekyll](https://jekyllrb.com/) and hosted with [GitHub Pages](https://pages.github.com/).

The website is completely static and does not include JavaScript except for the pages which need to display formulas. In that case, [MathJax](https://www.mathjax.org/) is included.

## Github Pages deployment

If you do not have it yet, install [Ruby](https://www.ruby-lang.org/en/). To install the latest version you can call:

```bash
make install-ruby
```

Install the Ruby gems with [Bundler](https://bundler.io/):

```bash
bundle install
```

or alternatively:

```bash
make install
```

> For other functionalities you can check out the [Makefile](Makefile) rules by typing:
> ```bash
> make help
> ```