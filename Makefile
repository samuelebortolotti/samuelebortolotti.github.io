# ======= PROGRAMS AND FLAGS =======
RUBY := ruby
GEM := gem
RBENV := rbenv
ENV := env
BUNDLE := bundle
EXEC := exec
JEKYLL := jekyll
SERVE := serve --watch
BUILD := build
LATEXMK := latexmk

# ======= CV =======
CVDIR := cv
CVBASE := samuele_bortolotti_cv
CVPDF := files/bortolotti_samuele_cv.pdf

# ======= COLORS ===================
RED := \033[31m
GREEN := \033[32m
YELLOW := \033[33m
BLUE := \033[34m
NONE := \033[0m

# ======= COMMANDS =================
ECHO := echo -e
OPEN := xdg-open

# RULES
.PHONY: help env install install-ruby serve build cv cv-clean

help:
	@$(ECHO) '$(YELLOW)Makefile help$(NONE)'
	@$(ECHO) " \
	* env 					: generates the virtual environment using the last version and rbenv\n \
	* install				: install the requirements listed in the Gemfile\n \
	* install-ruby				: install the last ruby version in rbenv\n \
	* serve				: build the site and make it available on a local server\n \
	* build				: build the site\n \
	* cv				: rebuild references.bib and compile the CV to $(CVPDF)\n \
	* cv-clean				: remove LaTeX build artefacts under $(CVDIR)/"

install-ruby:
	@export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
	@$(RBENV) install $($(RBENV) install -l | grep -v - | tail -1)
	@$(RBENV) local $($(RBENV) install -l | grep -v - | tail -1)
	@$(GEM) install bundler

install:
	@$(ECHO) '$(GREEN)Installing requirements..$(NONE)'
	@$(BUNDLE) install --path vendor/bundle
	@$(ECHO) '$(GREEN)Done$(NONE)'

serve:
	@$(ECHO) '$(BLUE)Building site and making it available locally..$(NONE)'
	(sleep 5; $(OPEN) http://127.0.0.1:4000) &
	@$(BUNDLE) $(EXEC) $(JEKYLL) $(SERVE)
	@$(ECHO) '$(BLUE)Done$(NONE)'

build:
	@$(ECHO) '$(BLUE)Building site..$(NONE)'
	@$(BUNDLE) $(EXEC) $(JEKYLL) $(BUILD)
	@$(ECHO) '$(BLUE)Done$(NONE)'

cv:
	@$(ECHO) '$(BLUE)Regenerating $(CVDIR)/resume/references.bib and _data/cv.yml..$(NONE)'
	@$(RUBY) scripts/gen_bib.rb
	@$(RUBY) scripts/cv_to_yaml.rb
	@$(RUBY) scripts/cv_i18n_check.rb
	@$(ECHO) '$(BLUE)Compiling the CV (xelatex + biber)..$(NONE)'
	@cd $(CVDIR) && $(LATEXMK) -xelatex -interaction=nonstopmode -halt-on-error $(CVBASE).tex
	@cp $(CVDIR)/$(CVBASE).pdf $(CVPDF)
	@cd $(CVDIR) && $(LATEXMK) -c >/dev/null
	@$(ECHO) '$(GREEN)Wrote $(CVPDF)$(NONE)'

cv-clean:
	@cd $(CVDIR) && $(LATEXMK) -C >/dev/null
	@$(ECHO) '$(GREEN)Cleaned $(CVDIR)/$(NONE)'