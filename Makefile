# Development Makefile for auxilium
SYS_PREFIX=/usr/local
DEV_PREFIX=$(HOME)/local
THISFILE:=$(lastword $(MAKEFILE_LIST))
ifndef VERBOSE
MAKEFLAGS += --no-print-directory
endif

.PHONY: all
all : build

#### Help stuff ####

.PHONY: help
help:
	@echo "Common building usage:"
	@echo "  make               # gen man and html documentation."
	@echo "  make docs          # gen man and html documentation."
	@echo "  make test          # run tests and save result to logs."
	@echo "  make checktest     # summary check of test logs."
	@echo "Common build cleanup usage:"
	@echo "  make cleantest     # copy test log files."
	@echo "  make cleandocs     # delete working copy of gen'd docs."
	@echo "  make clean         # clean tests and docs."
	@echo "Common installing usage:"
	@echo "  make devinstall    # copy files to under $(DEV_PREFIX)."
	@echo "  make sysinstall    # copy files to under $(SYS_PREFIX) as root."
	@echo "  make install PREFIX=<prefix> # custom copy files."
	@echo "Common uninstalling usage:"
	@echo "  make devuninstall  # delete files installed under $(DEV_PREFIX)."
	@echo "  make sysuninstall  # delete files installed under $(SYS_PREFIX) as root."
	@echo "  make uninstall PREFIX=<prefix> # custom uninstall files."

#### Building stuff #####

.PHONY: build
build: docs

.PHONY: docs
docs: share/man/man1           share/html/man/man1 \
  share/man/man1/auxenv.1      share/html/man/man1/auxenv.1.html \
  share/man/man1/auxsource.1   share/html/man/man1/auxsource.1.html \
  share/man/man1/auxalias.1    share/html/man/man1/auxalias.1.html \
  share/man/man1/auxchecktap.1 share/html/man/man1/auxchecktap.1.html \
  share/man/man1/auxguidish.1  share/html/man/man1/auxguidish.1.html

share/man/man1 :
	mkdir -p $@

share/html/man/man1 :
	mkdir -p $@

share/man/man1/auxenv.1 : man/auxenv.1.ronn
	ronn < $< > $@

share/html/man/man1/auxenv.1.html : man/auxenv.1.ronn
	ronn --html < $< > $@

share/man/man1/auxsource.1 : man/auxsource.1.ronn
	ronn < $< > $@

share/html/man/man1/auxsource.1.html : man/auxsource.1.ronn
	ronn --html < $< > $@

share/man/man1/auxalias.1 : man/auxalias.1.ronn
	ronn < $< > $@

share/html/man/man1/auxalias.1.html : man/auxalias.1.ronn
	ronn --html < $< > $@

share/man/man1/auxchecktap.1 : man/auxchecktap.1.ronn
	ronn < $< > $@

share/html/man/man1/auxchecktap.1.html : man/auxchecktap.1.ronn
	ronn --html < $< > $@

share/man/man1/auxguidish.1 : man/auxguidish.1.ronn
	ronn < $< > $@

share/html/man/man1/auxguidish.1.html : man/auxguidish.1.ronn
	ronn --html < $< > $@

#### Cleaning built stuff ####

.PHONY: cleandocs
cleandocs:
	rm -f share/man/man1/auxenv.1
	rm -f share/html/man/man1/auxenv.1.html
	rm -f share/man/man1/auxsource.1
	rm -f share/html/man/man1/auxsource.1.html
	rm -f share/man/man1/auxalias.1
	rm -f share/html/man/man1/auxalias.1.html
	rm -f share/man/man1/auxchecktap.1
	rm -f share/html/man/man1/auxchecktap.1.html
	rm -f share/man/man1/auxguidish.1
	rm -f share/html/man/man1/auxguidish.1.html

#### Testing stuff ####

#.PHONY: test
test: test/tap.log test/tap.chk

test/tap.log : bin/auxenv bin/auxsource bin/auxchecktap bin/auxguidish \
  $(wildcard test/*.bash) $(wildcard test/*.bats)
	cd test; bats -t . | tee tap.log

test/tap.chk : test/tap.log
	head -2 test/tap.log >  test/tap.chk
	tail -2 test/tap.log >> test/tap.chk

.PHONY: checktest
checktest: test/tap.chk
	@cat test/tap.chk

#### Cleaning test logs ####

.PHONY: cleantest
cleantest:
	rm -f test/tap.log
	rm -f test/tap.chk

#### install stuff ####

.PHONY: devinstall
devinstall:
	@$(MAKE) $(THISFILE) doinstall PREFIX=$(DEV_PREFIX)

.PHONY: sysinstall
sysinstall:
	@sudo $(MAKE) $(THISFILE) doinstall PREFIX=$(SYS_PREFIX)

.PHONY: install
install :
	@if [ -z "$(PREFIX)" ]; then echo "ERROR: No PREFIX variable defined."; exit 1; fi
	@$(MAKE) $(THISFILE) doinstall PREFIX=$(PREFIX)

.PHONY: doinstall
doinstall : doinstallinfo \
  $(PREFIX)/bin \
  $(PREFIX)/bin/auxenv \
  $(PREFIX)/bin/auxsource \
  $(PREFIX)/bin/auxalias \
  $(PREFIX)/bin/auxchecktap \
  $(PREFIX)/bin/auxguidish \
  $(PREFIX)/share/man/man1 \
  $(PREFIX)/share/man/man1/auxenv.1 \
  $(PREFIX)/share/man/man1/auxsource.1 \
  $(PREFIX)/share/man/man1/auxalias.1 \
  $(PREFIX)/share/man/man1/auxchecktap.1 \
  $(PREFIX)/share/man/man1/auxguidish.1 \
  $(PREFIX)/share/html/man/man1 \
  $(PREFIX)/share/html/man/man1/auxenv.1.html \
  $(PREFIX)/share/html/man/man1/auxsource.1.html \
  $(PREFIX)/share/html/man/man1/auxalias.1.html \
  $(PREFIX)/share/html/man/man1/auxchecktap.1.html \
  $(PREFIX)/share/html/man/man1/auxguidish.1.html \
  doinstallinfo2

.PHONY: doinstallinfo
doinstallinfo:
	@echo "INFO: doing auxilium install under $(PREFIX) as user $$(whoami)."

.PHONY: doinstallinfo2
doinstallinfo2:
	@echo "INFO: Auxilium installed under $(PREFIX) as user $$(whoami)."
	@fullprefix=$$(readlink -f $(PREFIX)) ; \
  curuser=$$(whoami) ; \
  rcfile=~/.bashrc; \
  if [ "$$curuser" == "root" ]; then rcfile=/etc/bashrc; fi ; \
  echo "NOTE: We recommended adding \"source $$fullprefix/bin/auxalias\" to $$rcfile."

$(PREFIX)/bin:
	mkdir -p $@

$(PREFIX)/bin/auxenv : bin/auxenv
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/bin/auxsource : bin/auxsource
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/bin/auxalias : bin/auxalias
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/bin/auxchecktap : bin/auxchecktap
	cp -a $< $@
	chmod a+r "$@"
	chmod a-x "$@"

$(PREFIX)/bin/auxguidish : bin/auxguidish
	cp -a $< $@
	chmod a+r+x "$@"

$(PREFIX)/share/man/man1:
	mkdir -p $@

$(PREFIX)/share/man/man1/auxenv.1: share/man/man1/auxenv.1
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/man/man1/auxsource.1: share/man/man1/auxsource.1
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/man/man1/auxalias.1: share/man/man1/auxalias.1
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/man/man1/auxchecktap.1: share/man/man1/auxchecktap.1
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/man/man1/auxguidish.1: share/man/man1/auxguidish.1
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/html/man/man1:
	mkdir -p $@

$(PREFIX)/share/html/man/man1/auxenv.1.html: share/html/man/man1/auxenv.1.html
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/html/man/man1/auxsource.1.html: share/html/man/man1/auxsource.1.html
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/html/man/man1/auxalias.1.html: share/html/man/man1/auxalias.1.html
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/html/man/man1/auxchecktap.1.html: share/html/man/man1/auxchecktap.1.html
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/html/man/man1/auxguidish.1.html: share/html/man/man1/auxguidish.1.html
	cp -a $< $@
	chmod a+r-x "$@"

#### uninstall stuff ####

.PHONY: devuninstall
devuninstall:
	@$(MAKE) $(THISFILE) douninstall PREFIX=$(DEV_PREFIX)

.PHONY: sysuninstall
sysuninstall:
	@sudo $(MAKE) $(THISFILE) douninstall PREFIX=$(SYS_PREFIX)

.PHONY: uninstall
uninstall:
	@if [ -z "$(PREFIX)" ]; then echo "ERROR: No PREFIX variable defined."; exit 1; fi
	@$(MAKE) $(THISFILE) douninstall PREFIX=$(PREFIX)

.PHONY: douninstall
douninstall:
	@echo "INFO: doing uninstall from $(PREFIX) as user $$(whoami)."
	rm -f $(PREFIX)/bin/auxenv
	rm -f $(PREFIX)/bin/auxsource
	rm -f $(PREFIX)/bin/auxalias
	rm -f $(PREFIX)/bin/auxchecktap
	rm -f $(PREFIX)/bin/auxguidish
	rm -f $(PREFIX)/share/man/man1/auxenv.1
	rm -f $(PREFIX)/share/man/man1/auxsource.1
	rm -f $(PREFIX)/share/man/man1/auxalias.1
	rm -f $(PREFIX)/share/man/man1/auxchecktap.1
	rm -f $(PREFIX)/share/man/man1/auxguidish.1
	rm -f $(PREFIX)/share/html/man/man1/auxenv.1
	rm -f $(PREFIX)/share/html/man/man1/auxsource.1
	rm -f $(PREFIX)/share/html/man/man1/auxalias.1
	rm -f $(PREFIX)/share/html/man/man1/auxchecktap.1
	rm -f $(PREFIX)/share/html/man/man1/auxguidish.1

#### Aggregate stuff ####

.PHONY: clean
clean: cleantest cleandocs

#### git stuff ####

.PHONY: gitpush
gitpush:
	git push origin master
