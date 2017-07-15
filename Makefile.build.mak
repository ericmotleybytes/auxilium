###
# This file designed to be included by Makefile.
###
MAN1HEADER=General Commands
PANDOCSTD=pandoc -s --from=markdown
PANDOCMAN1=$(PANDOCSTD) --to=man -M adjusting=l -M hyphenate=false -M section=1
PANDOCMAN=$(PANDOCMAN1) -M header="$(MAN1HEADER)" -M footer="$(CURDATE)"
PANDOCHTML=$(PANDOCSTD) --to=html --self-contained
PANDOCHTMLMAN=$(PANDOCHTML) --toc -M auxdate="$(CURDATE)"
PANDOCHTMLMANUAL=$(PANDOCHTML) --toc
PANDOCHTMLINFO=$(PANDOCHTML) --toc -M auxdate="$(CURDATE)"
PANDOCPDF1=$(PANDOCSTD) --to=latex -M papersize=letter -M colorlinks
PANDOCPDF2=$(PANDOCPDF1) -M margin-left=1in -M margin-right=1in
PANDOCPDF=$(PANDOCPDF2) -M margin-top=1in -M margin-bottom=1in
PANDOCPDFMANUAL=$(PANDOCPDF) --toc
AUXILIUM_UG_SUBTITLE=Version $(THISREL)
AUXILIUM_DG_SUBTITLE=Version $(THISREL)

.PHONY: helpbuild
helpbuild:
	@echo "Common building usage:"
	@echo "  make helpbuild     # display this screen."
	@echo "  make build         # build docs and more."
	@echo "  make test          # run tests."
	@echo "  make checktest     # run tests and remember results."
	@echo "Common build cleanup usage:"
	@echo "  make clean         # clean tests and docs."
	@echo "  make cleantest     # copy test log files."
	@echo "  make cleandocs     # delete working copy of gen'd docs."

#### Dependency stuff ####

.PHONY: depends
depends: doc/man/auxenv.ppi.md.dep \
  doc/man/auxsource.ppi.md.dep \
  doc/man/auxalias.ppi.md.dep \
  doc/man/auxwhere.ppi.md.dep \
  doc/man/auxchecktap.ppi.md.dep \
  doc/man/auxguid.ppi.md.dep \
  doc/man/auxilium.ppi.md.dep \
  doc/include/template-aliasing.ppi.md.dep \
  doc/html/index.ppi.md.dep \
  doc/manuals/auxilium-user-guide.ppi.md.dep \
  doc/manuals/auxilium-dev-guide.ppi.md.dep \
  doc/docs/index.ppi.md.dep \
  doc/readme/readme.ppi.md.dep

doc/man/auxenv.ppi.md.dep : doc/man/auxenv.ppi.md
	sbin/pp-dep $< > $@

doc/man/auxsource.ppi.md.dep : doc/man/auxsource.ppi.md
	sbin/pp-dep $< > $@

doc/man/auxalias.ppi.md.dep : doc/man/auxalias.ppi.md
	sbin/pp-dep $< > $@

doc/man/auxwhere.ppi.md.dep : doc/man/auxwhere.ppi.md
	sbin/pp-dep $< > $@

doc/man/auxchecktap.ppi.md.dep : doc/man/auxchecktap.ppi.md
	sbin/pp-dep $< > $@

doc/man/auxguid.ppi.md.dep : doc/man/auxguid.ppi.md
	sbin/pp-dep $< > $@

doc/man/auxilium.ppi.md.dep : doc/man/auxilium.ppi.md
	sbin/pp-dep $< > $@

doc/include/template-aliasing.ppi.md.dep : doc/include/template-aliasing.ppi.md
	sbin/pp-dep $< > $@

doc/html/index.ppi.md.dep : doc/html/index.ppi.md
	sbin/pp-dep $< > $@

doc/manuals/auxilium-user-guide.ppi.md.dep : doc/manuals/auxilium-user-guide.ppi.md
	sbin/pp-dep $< > $@

doc/manuals/auxilium-dev-guide.ppi.md.dep : doc/manuals/auxilium-dev-guide.ppi.md
	sbin/pp-dep $< > $@

doc/docs/index.ppi.md.dep : doc/docs/index.ppi.md
	sbin/pp-dep $< > $@

doc/readme/readme.ppi.md.dep : doc/readme/readme.ppi.md
	sbin/pp-dep $< > $@

#### Building stuff #####

.PHONY: build
build: depends docs
	@echo "[build complete]"

.PHONY: docs
docs: doc/include/auxenv-aliasing.ppo.md \
  doc/include/auxsource-aliasing.ppo.md \
  doc/include/auxalias-aliasing.ppo.md \
  share/man/man1 \
    share/man/man1/auxenv.1 \
    share/man/man1/auxsource.1 \
    share/man/man1/auxwhere.1 \
    share/man/man1/auxalias.1 \
    share/man/man1/auxchecktap.1 \
    share/man/man1/auxguid.1 \
    share/man/man1/auxilium.1 \
  share/html/man/man1 \
    share/html/man/man1/auxenv.1.html \
    share/html/man/man1/auxsource.1.html \
    share/html/man/man1/auxwhere.1.html \
    share/html/man/man1/auxalias.1.html \
    share/html/man/man1/auxchecktap.1.html \
    share/html/man/man1/auxguid.1.html \
    share/html/man/man1/auxilium.1.html \
  share/html/auxilium \
    share/html/auxilium/index.html \
    share/html/auxilium/auxilium-user-guide.html \
    share/html/auxilium/auxilium-user-guide.pdf \
    share/html/auxilium/auxilium-dev-guide.html \
    share/html/auxilium/auxilium-dev-guide.pdf \
  doc/docs/index.html \
  doc/readme/readme.ppo.md \
  doc/readme/readme.html \
  doc/readme/README.md

doc/include/auxenv-aliasing.ppo.md : doc/include/template-aliasing.ppi.md \
  $(shell sbin/pp-putdep doc/include/template-aliasing.ppi.md.dep)
	pp -D AUXCMD=auxenv $< > $@

doc/include/auxsource-aliasing.ppo.md : doc/include/template-aliasing.ppi.md \
  $(shell sbin/pp-putdep doc/include/template-aliasing.ppi.md.dep)
	pp -D AUXCMD=auxsource $< > $@

doc/include/auxalias-aliasing.ppo.md : doc/include/template-aliasing.ppi.md \
  $(shell sbin/pp-putdep doc/include/template-aliasing.ppi.md.dep)
	pp -D AUXCMD=auxalias $< > $@

# generic man stuff

doc/man/auxenv.ppo.md : doc/man/auxenv.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxenv.ppi.md.dep)
	pp $< > $@

doc/man/auxsource.ppo.md : doc/man/auxsource.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxsource.ppi.md.dep)
	pp $< > $@

doc/man/auxwhere.ppo.md : doc/man/auxwhere.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxwhere.ppi.md.dep)
	pp $< > $@

doc/man/auxalias.ppo.md : doc/man/auxalias.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxalias.ppi.md.dep)
	pp $< > $@

doc/man/auxchecktap.ppo.md : doc/man/auxchecktap.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxchecktap.ppi.md.dep)
	pp $< > $@

doc/man/auxguid.ppo.md : doc/man/auxguid.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxguid.ppi.md.dep)
	pp $< > $@

doc/man/auxilium.ppo.md : doc/man/auxilium.ppi.md \
  $(shell sbin/pp-putdep doc/man/auxilium.ppi.md.dep)
	pp $< > $@

# man in man format stuff

share/man/man1 :
	mkdir -p $@

share/man/man1/auxenv.1 : doc/man/auxenv.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxenv

share/man/man1/auxsource.1 : doc/man/auxsource.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxenv

share/man/man1/auxwhere.1 : doc/man/auxwhere.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxwhere

share/man/man1/auxalias.1 : doc/man/auxalias.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxenv

share/man/man1/auxchecktap.1 : doc/man/auxchecktap.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxchecktap

share/man/man1/auxguid.1 : doc/man/auxguid.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxguid

share/man/man1/auxilium.1 : doc/man/auxilium.ppo.md
	$(PANDOCMAN) $< --output=$@ -M title=auxilium

# man in html format stuff

share/html/man/man1 :
	mkdir -p $@

share/html/man/man1/auxenv.1.html : doc/man/auxenv.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxenv-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxenv-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

share/html/man/man1/auxsource.1.html : doc/man/auxsource.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxsource-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxsource-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

share/html/man/man1/auxwhere.1.html : doc/man/auxwhere.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxwhere-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxwhere-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

share/html/man/man1/auxalias.1.html : doc/man/auxalias.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxalias-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxalias-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

share/html/man/man1/auxchecktap.1.html : doc/man/auxchecktap.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxchecktap-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxchecktap-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

share/html/man/man1/auxguid.1.html : doc/man/auxguid.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxguid-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxguid-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

share/html/man/man1/auxilium.1.html : doc/man/auxilium.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template \
  doc/include/auxilium-title.md
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-title.md)" \
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

# documentation index page

share/html/auxilium :
	mkdir -p $@

doc/html/index.ppo.md : doc/html/index.ppi.md \
  $(shell sbin/pp-putdep doc/html/index.ppi.md.dep)
	pp $< > $@

share/html/auxilium/index.html : doc/html/index.ppo.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template
	$(PANDOCHTMLMAN) $< --output=$@ -M title="auxilium documentation"
          --template=doc/templates/man.html.pandoc.template -H doc/css/man.css

# user guide

doc/manuals/auxilium-user-guide.ppo.md : doc/manuals/auxilium-user-guide.ppi.md \
  $(shell sbin/pp-putdep doc/manuals/auxilium-user-guide.ppi.md.dep)
	pp $< > $@

share/html/auxilium/auxilium-user-guide.html : \
  doc/manuals/auxilium-user-guide.ppo.md \
  doc/css/manual.css \
  doc/include/auxilium-user-guide-title.md
	$(PANDOCHTMLMANUAL) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-user-guide-title.md)" \
          -M subtitle="$(AUXILIUM_UG_SUBTITLE)" --toc-depth=2 -H doc/css/manual.css

share/html/auxilium/auxilium-user-guide.pdf : doc/manuals/auxilium-user-guide.ppo.md \
  doc/templates/info.latex.pandoc.template \
  doc/include/auxilium-user-guide-title.md
	$(PANDOCPDFMANUAL) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-user-guide-title.md)" \
          -M date="Version $(THISREL)" --toc-depth=2 \
          --template=doc/templates/info.latex.pandoc.template

# developer guide

doc/manuals/auxilium-dev-guide.ppo.md : doc/manuals/auxilium-dev-guide.ppi.md \
  $(shell sbin/pp-putdep doc/manuals/auxilium-dev-guide.ppi.md.dep)
	pp $< > $@

share/html/auxilium/auxilium-dev-guide.html : \
  doc/manuals/auxilium-dev-guide.ppo.md \
  doc/css/manual.css \
  doc/include/auxilium-dev-guide-title.md
	$(PANDOCHTMLMANUAL) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-dev-guide-title.md)" \
          -M subtitle="$(AUXILIUM_DG_SUBTITLE)" --toc-depth=2 -H doc/css/manual.css

share/html/auxilium/auxilium-dev-guide.pdf : doc/manuals/auxilium-dev-guide.ppo.md \
  doc/templates/info.latex.pandoc.template \
  doc/include/auxilium-dev-guide-title.md
	$(PANDOCPDFMANUAL) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-dev-guide-title.md)" \
          -M date="Version $(THISREL)" --toc-depth=2 \
          --template=doc/templates/info.latex.pandoc.template

# info and download site

doc/docs/index.ppo.md : doc/docs/index.ppi.md \
  data/releases.dat \
  data/releases.log \
  sbin/show-rels-html \
  $(shell sbin/pp-putdep doc/docs/index.ppi.md.dep)
	pp $< > $@

# github pages stuff

doc/docs/index.html : doc/docs/index.ppo.md \
  doc/css/info.css \
  doc/templates/info.html.pandoc.template \
  doc/include/auxilium-info-page-title.md
	$(PANDOCHTMLINFO) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-info-page-title.md)" \
          -H doc/css/info.css \
          --template=doc/templates/info.html.pandoc.template

# README.md stuff

doc/readme/readme.ppo.md : doc/readme/readme.ppi.md \
  $(shell sbin/pp-putdep doc/readme/readme.ppi.md.dep)
	pp $< > $@

doc/readme/readme.html : doc/readme/readme.ppo.md \
  doc/include/auxilium-title.md \
  doc/css/man.css \
  doc/templates/man.html.pandoc.template
	$(PANDOCHTMLMAN) $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-title.md)" \
          --template=doc/templates/man.html.pandoc.template \
          -H doc/css/man.css

doc/readme/README.md : doc/readme/readme.ppo.md
	pandoc -s --from=markdown --to=markdown_github \
          --toc $< --output=$@ \
          -M title="$(shell head -1 doc/include/auxilium-title.md)"

#### Cleaning built stuff ####

.PHONY: cleandocs
cleandocs:
	rm -f doc/man/auxenv.ppi.md.dep
	rm -f doc/man/auxsource.ppi.md.dep
	rm -f doc/man/auxalias.ppi.md.dep
	rm -f doc/man/auxwhere.ppi.md.dep
	rm -f doc/man/auxchecktap.ppi.md.dep
	rm -f doc/man/auxguid.ppi.md.dep
	rm -f doc/man/auxilium.ppi.md.dep
	rm -f doc/include/template-aliasing.ppi.md.dep
	rm -f doc/html/index.ppi.md.dep
	rm -f doc/manuals/auxilium-user-guide.ppi.md.dep
	rm -f doc/docs/index.ppi.md.dep
	rm -f doc/readme/readme.ppi.md.dep
	rm -f doc/man/auxenv.ppo.md
	rm -f doc/man/auxsource.ppo.md
	rm -f doc/man/auxwhere.ppo.md
	rm -f doc/man/auxalias.ppo.md
	rm -f doc/man/auxchecktap.ppo.md
	rm -f doc/man/auxguid.ppo.md
	rm -f doc/man/auxilium.ppo.md
	rm -f share/man/man1/auxenv.1
	rm -f share/html/man/man1/auxenv.1.html
	rm -f share/man/man1/auxsource.1
	rm -f share/html/man/man1/auxsource.1.html
	rm -f share/man/man1/auxwhere.1
	rm -f share/html/man/man1/auxwhere.1.html
	rm -f share/man/man1/auxalias.1
	rm -f share/html/man/man1/auxalias.1.html
	rm -f share/man/man1/auxchecktap.1
	rm -f share/html/man/man1/auxchecktap.1.html
	rm -f share/man/man1/auxguid.1
	rm -f share/html/man/man1/auxguid.1.html
	rm -f share/man/man1/auxilium.1
	rm -f share/html/man/man1/auxilium.1.html
	rm -f doc/html/index.ppo.md
	rm -f share/html/auxilium/index.html
	rm -f share/html/auxilium/auxilium-user-guide.html
	rm -f share/html/auxilium/auxilium-user-guide.pdf
	rm -f doc/docs/index.ppo.md
	rm -f doc/docs/index.html
	rm -f doc/readme/readme.ppo.md
	rm -f doc/readme/readme.html
	rm -f doc/readme/README.md

#### Aggregate stuff ####

.PHONY: clean
clean: cleantest cleandocs
