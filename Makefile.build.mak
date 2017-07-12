###
# This file designed to be included by Makefile.
###
PANDOCSTD=pandoc -s --from=markdown
PANDOCMAN1=$(PANDOCSTD) --to=man -M adjusting=l -M hyphenate=false -M section=1
PANDOCMAN=$(PANDOCMAN1) -M header="General Commands Manual" -M footer="$(CURDATE)"
PANDOCHTML=$(PANDOCSTD) --to=html --self-contained
PANDOCHTMLMAN1=$(PANDOCHTML) --toc -H doc/css/man.css -M auxdate="$(CURDATE)"
PANDOCHTMLMAN=$(PANDOCHTMLMAN1) --template=doc/templates/man.html.pandoc.template
PANDOCHTMLMANUAL=$(PANDOCHTML) --toc -H doc/css/manual.css
PANDOCHTMLINFO1=$(PANDOCHTML) --toc -H doc/css/info.css -M auxdate="$(CURDATE)"
PANDOCHTMLINFO=$(PANDOCHTMLINFO1) --template=doc/templates/info.html.pandoc.template
PANDOCPDF1=$(PANDOCSTD) --to=latex -M papersize=letter -M colorlinks
PANDOCPDF2=$(PANDOCPDF1) -M margin-left=1in -M margin-right=1in
PANDOCPDF3=$(PANDOCPDF2) -M margin-top=1in -M margin-bottom=1in
PANDOCPDF=$(PANDOCPDF3) --template=doc/templates/info.latex.pandoc.template
PANDOCPDFMANUAL=$(PANDOCPDF) --toc -M toc-depth=3 
AUXENV_TITLE=$(shell head -1 doc/include/auxenv-title.md)
AUXSOURCE_TITLE=$(shell head -1 doc/include/auxsource-title.md)
AUXWHERE_TITLE=$(shell head -1 doc/include/auxwhere-title.md)
AUXALIAS_TITLE=$(shell head -1 doc/include/auxalias-title.md)
AUXCHECKTAP_TITLE=$(shell head -1 doc/include/auxchecktap-title.md)
AUXGUID_TITLE=$(shell head -1 doc/include/auxguid-title.md)
AUXILIUM_TITLE=$(shell head -1 doc/include/auxilium-title.md)
AUXILIUM_UG_TITLE=$(shell head -1 doc/include/auxilium-user-guide-title.md)
AUXILIUM_UG_SUBTITLE=Version $(THISREL)
AUXILIUM_INFO_TITLE=$(shell head -1 doc/include/auxilium-info-page-title.md)

.PHONY: helpbuild
helpbuild:
	@echo "Common building usage:"
	@echo "  make helpbuild     # display this screen."
	@echo "  make docs          # gen man and html documentation."
	@echo "  make test          # run tests and save result to logs."
	@echo "  make checktest     # summary check of test logs."
	@echo "Common build cleanup usage:"
	@echo "  make cleantest     # copy test log files."
	@echo "  make cleandocs     # delete working copy of gen'd docs."
	@echo "  make clean         # clean tests and docs."
	@echo "Common installing usage:"
	@echo "  make install       # copy files to under $(DEV_PREFIX)."
	@echo "  make sysinstall    # copy files to under $(SYS_PREFIX) as root."
	@echo "  make install PREFIX=<prefix> # custom copy files."
	@echo "Common uninstalling usage:"
	@echo "  make uninstall     # delete files installed under $(DEV_PREFIX)."
	@echo "  make sysuninstall  # delete files installed under $(SYS_PREFIX) as root."
	@echo "  make uninstall PREFIX=<prefix> # custom uninstall files."

#### Building stuff #####

.PHONY: build
build: docs
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
  doc/docs/index.html

doc/include/auxenv-aliasing.ppo.md : doc/include/template-aliasing.ppi.md
	pp -D AUXCMD=auxenv $< > $@

doc/include/auxsource-aliasing.ppo.md : doc/include/template-aliasing.ppi.md
	pp -D AUXCMD=auxsource $< > $@

doc/include/auxalias-aliasing.ppo.md : doc/include/template-aliasing.ppi.md
	pp -D AUXCMD=auxalias $< > $@

# generic man stuff

doc/man/auxenv.ppo.md : doc/man/auxenv.ppi.md doc/include
	pp $< > $@

doc/man/auxsource.ppo.md : doc/man/auxsource.ppi.md doc/include
	pp $< > $@

doc/man/auxwhere.ppo.md : doc/man/auxwhere.ppi.md doc/include
	pp $< > $@

doc/man/auxalias.ppo.md : doc/man/auxalias.ppi.md doc/include
	pp $< > $@

doc/man/auxchecktap.ppo.md : doc/man/auxchecktap.ppi.md doc/include
	pp $< > $@

doc/man/auxguid.ppo.md : doc/man/auxguid.ppi.md doc/include
	pp $< > $@

doc/man/auxilium.ppo.md : doc/man/auxilium.ppi.md doc/include
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

share/html/man/man1/auxenv.1.html : doc/man/auxenv.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXENV_TITLE)"

share/html/man/man1/auxsource.1.html : doc/man/auxsource.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXSOURCE_TITLE)"

share/html/man/man1/auxwhere.1.html : doc/man/auxwhere.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXWHERE_TITLE)"

share/html/man/man1/auxalias.1.html : doc/man/auxalias.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXALIAS_TITLE)"

share/html/man/man1/auxchecktap.1.html : doc/man/auxchecktap.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXCHECKTAP_TITLE)"

share/html/man/man1/auxguid.1.html : doc/man/auxguid.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXGUID_TITLE)"

share/html/man/man1/auxilium.1.html : doc/man/auxilium.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="$(AUXILIUM_TITLE)"

# documentation index page

share/html/auxilium :
	mkdir -p $@

doc/html/index.ppo.md : doc/html/index.ppi.md
	pp $< > $@

share/html/auxilium/index.html : doc/html/index.ppo.md doc/css doc/templates
	$(PANDOCHTMLMAN) $< --output=$@ -M title="auxilium documentation"

# users guide

doc/manuals/auxilium-user-guide.ppo.md : doc/manuals/auxilium-user-guide.ppi.md doc/include
	pp $< > $@

share/html/auxilium/auxilium-user-guide.html : \
  doc/manuals/auxilium-user-guide.ppo.md \
  doc/css doc/templates
	$(PANDOCHTMLMANUAL) $< --output=$@ -M title="$(AUXILIUM_UG_TITLE)" \
          -M subtitle="$(AUXILIUM_UG_SUBTITLE)"

share/html/auxilium/auxilium-user-guide.pdf : doc/manuals/auxilium-user-guide.ppo.md
	$(PANDOCPDFMANUAL) $< --output=$@ -M title="$(AUXILIUM_UG_TITLE)" \
          -M date="Version $(THISREL)"

doc/docs/index.ppo.md : doc/docs/index.ppi.md \
  data/releases.dat \
  data/releases.log \
  sbin/show-rels-html \
  doc/include
	pp $< > $@

# github pages stuff

doc/docs/index.html : doc/docs/index.ppo.md \
  doc/css \
  doc/templates
	$(PANDOCHTMLINFO) $< --output=$@ -M title="$(AUXILIUM_INFO_TITLE)"

#### Cleaning built stuff ####

.PHONY: cleandocs
cleandocs:
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

#### Aggregate stuff ####

.PHONY: clean
clean: cleantest cleandocs
