###
# Development Sources Makefile for auxilium
###
SYS_PREFIX=/usr/local
DEV_PREFIX=$(HOME)/local
NEXTREL=0.1.2
RUNTIME=auxilium-runtime-$(NEXTREL)
RUNTIMEDIR=dist/$(RUNTIME)
THISFILE:=$(lastword $(MAKEFILE_LIST))
ifndef VERBOSE
MAKEFLAGS += --no-print-directory
endif

.PHONY: all
all : help

#### Help stuff ####

.PHONY: help
help:
	@echo "Available help topics:"
	@echo "  make               # display this screen."
	@echo "  make help          # display this screen."
	@echo "  make helpbuild     # help building sources."
	@echo "  make helpgit       # help common git tasks."
	@echo "  make helprel       # help common GitHub release tasks."
	@echo "  make helprelcheck  # help GitHub release checklist."

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
	@echo "  make devinstall    # copy files to under $(DEV_PREFIX)."
	@echo "  make sysinstall    # copy files to under $(SYS_PREFIX) as root."
	@echo "  make install PREFIX=<prefix> # custom copy files."
	@echo "Common uninstalling usage:"
	@echo "  make devuninstall  # delete files installed under $(DEV_PREFIX)."
	@echo "  make sysuninstall  # delete files installed under $(SYS_PREFIX) as root."
	@echo "  make uninstall PREFIX=<prefix> # custom uninstall files."

.PHONY: helpgit
helpgit:
	@echo "Common git actions:"
	@echo "  make helpgit # display this screen."
	@echo "  make push    # git push origin master"
	@echo "  make pull    # git pull origin master"
	@echo "  make gitstat # git status --short --branch"
	@echo "  make taglist # git tag --list"

.PHONY: helprel
helprel:
	@echo "Common Help for release actions:"
	@echo "  make helprel                  # display this screen."
	@echo "  make helprelcheck             # see a release checklist."
	@echo "  make show-next-release        # version being built to be released next."
	@echo "  make show-remote-release-tags # release tags on GitHub server."
	@echo "  make show-local-release-tags  # release tags on local server."
	@echo "  make clean-runtime-dist       # clean distribution area."
	@echo "  make runtime-dist             # create distribution and tarball."
	@echo "  make list-runtime-dist        # list contents of dist tarball."
	@echo "  make local-release-tag        # tag files locally."
	@echo "  make push-release-tag         # tag files on remote."

.PHONY: helprelcheck
helprelcheck:
	@echo "Release help:"
	@echo "  make helprelcheck             # display this screen."
	@echo "  make helprel                  # abbreviate release help."
	@echo "Before releasing checklist:"
	@echo "  make build     # make sure all software docs built."
	@echo "  make checktest # make sure all unit tests pass."
	@echo "  make -f $(GITMAK) status # look for clean status."
	@echo "    # make sure all proper 'git add <file>' commands issued"
	@echo "    # make sure all proper 'git commit ...' commands issued."
	@echo "  make -f $(GITMAK) pull # pull down any remote changes made since your pull."
	@echo "  make -f $(GITMAK) status # look for clean status again."
	@echo "  make -f $(GITMAK) push   # do a normal push to the remote."
	@echo "Release Checklist:"
	@echo "  # View previous release tags on remote..."
	@echo "    make -f $(THISFILE) show-remote-release-tags"
	@echo "      # if you see a remote release tag that WAS NOT ACTUALLY RELEASED,"
	@echo "      # you might want to (but probably should not) delete the remote tag."
	@echo "        git push --delete origin <release-tag>"
	@echo "      # decide what the new next release version should be and remember it."
	@echo "  # View existing local release tags..."
	@echo "    make -f $(THISFILE) show-local-release-tags"
	@echo "      # Make sure the new next release version not already been used."
	@echo "      # If you really want to reuse a version which is only locally tagged,"
	@echo "      # you could delete the old tag definition tag locally."
	@echo "        git tag --delete <release-tag>."
	@echo "  # View the currently configured next release version number."
	@echo "    make -f $(THISFILE) show-next-release."
	@echo "  # If needed, edit $(THISFILE) and find the 'NEXTREL=...' line towards the top."
	@echo "  # Edit/change this release version to the new release version you picked."
	@echo "  # Save the edited file."
	@echo "  # Verify your change:"
	@echo "    make -f $(THISFILE) show-next-release."
	@echo "  # Optional: Make sure the runtime distribution area is clean."
	@echo "    make -f $(THISFILE) clean-runtime-dist"
	@echo "  # Make the runtime-only distribution tarball."
	@echo "    make -f $(THISFILE) runtime-dist"
	@echo "  # Verify the contents of the runtime tarball."
	@echo "    make -f $(THISFILE) list-runtime-dist"
	@echo "  # Tag local files source files with the release tag."
	@echo "    make -f $(THISFILE) local-release-tag"
	@echo "  # Push the release tag to the remote."
	@echo "    make -f $(THISFILE) push-release-tag"
	@echo "  # With a web browser goto the GitHub repository page."
	@echo "    # Using the GitHub web interface:"
	@echo "      # Create/edit new tagged release."
	@echo "      # Upload the runtime tarbar dist/$(RUNTIME).tar.gz."
	@echo "      # Publish the release."

#### Building stuff #####

.PHONY: build
build: docs

.PHONY: docs
docs: doc/README.md \
  share/man/man1           share/html/man/man1 \
  share/man/man1/auxenv.1      share/html/man/man1/auxenv.1.html \
  share/man/man1/auxsource.1   share/html/man/man1/auxsource.1.html \
  share/man/man1/auxalias.1    share/html/man/man1/auxalias.1.html \
  share/man/man1/auxchecktap.1 share/html/man/man1/auxchecktap.1.html \
  share/man/man1/auxguid.1     share/html/man/man1/auxguid.1.html \
  share/html/auxilium.README.md.html

doc/README.md : doc/README.mdpp \
  doc/auxilium-general.mdpp \
  doc/install.mdpp doc \
  doc/install-runtime.mdpp \
  doc/install-sources.mdpp
	cd doc ; markdown-pp README.mdpp -o README.md

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

share/man/man1/auxguid.1 : man/auxguid.1.ronn
	ronn < $< > $@

share/html/man/man1/auxguid.1.html : man/auxguid.1.ronn
	ronn --html < $< > $@

share/html/auxilium.README.md.html : README.md
	grip $< --export $@

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
	rm -f share/man/man1/auxguid.1
	rm -f share/html/man/man1/auxguid.1.html
	rm -f share/html/auxilium.README.md.html

#### Testing stuff ####

#.PHONY: test
test: test/auxilium.taplog test/auxilium.tapchk

test/auxilium.taplog : bin/auxenv bin/auxsource bin/auxalias bin/auxchecktap bin/auxguid \
  $(wildcard test/*.bash) $(wildcard test/*.bats)
	cd test; bats -t . | tee auxilium.taplog

test/auxilium.tapchk : test/auxilium.taplog
	auxchecktap $< $@

.PHONY: checktest
checktest: test/auxilium.tapchk
	auxchecktap $<

#### Cleaning test logs ####

.PHONY: cleantest
cleantest:
	rm -f test/auxilium.taplog
	rm -f test/auxilium.tapchk

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
  $(PREFIX)/bin/auxguid \
  $(PREFIX)/share/man/man1 \
  $(PREFIX)/share/man/man1/auxenv.1 \
  $(PREFIX)/share/man/man1/auxsource.1 \
  $(PREFIX)/share/man/man1/auxalias.1 \
  $(PREFIX)/share/man/man1/auxchecktap.1 \
  $(PREFIX)/share/man/man1/auxguid.1 \
  $(PREFIX)/share/html/man/man1 \
  $(PREFIX)/share/html/man/man1/auxenv.1.html \
  $(PREFIX)/share/html/man/man1/auxsource.1.html \
  $(PREFIX)/share/html/man/man1/auxalias.1.html \
  $(PREFIX)/share/html/man/man1/auxchecktap.1.html \
  $(PREFIX)/share/html/man/man1/auxguid.1.html \
  doinstallprotect doinstallinfo2

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

.PHONY: doinstallprotect
doinstallprotect:
	chmod -R a+r $(PREFIX)/share

$(PREFIX)/bin:
	mkdir -p $@
	chmod a+r $@

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
	cp -a $< "$@"
	chmod a+r+x "$@"

$(PREFIX)/bin/auxguid : bin/auxguid
	cp -a $< $@
	chmod a+r+x "$@"

$(PREFIX)/share/man/man1:
	mkdir -p $@
	chmod a+r $@

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

$(PREFIX)/share/man/man1/auxguid.1: share/man/man1/auxguid.1
	cp -a $< $@
	chmod a+r-x "$@"

$(PREFIX)/share/html/man/man1:
	mkdir -p $@
	chmod a+r $@

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

$(PREFIX)/share/html/man/man1/auxguid.1.html: share/html/man/man1/auxguid.1.html
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
	rm -f $(PREFIX)/bin/auxguid
	rm -f $(PREFIX)/share/man/man1/auxenv.1
	rm -f $(PREFIX)/share/man/man1/auxsource.1
	rm -f $(PREFIX)/share/man/man1/auxalias.1
	rm -f $(PREFIX)/share/man/man1/auxchecktap.1
	rm -f $(PREFIX)/share/man/man1/auxguid.1
	rm -f $(PREFIX)/share/html/man/man1/auxenv.1
	rm -f $(PREFIX)/share/html/man/man1/auxsource.1
	rm -f $(PREFIX)/share/html/man/man1/auxalias.1
	rm -f $(PREFIX)/share/html/man/man1/auxchecktap.1
	rm -f $(PREFIX)/share/html/man/man1/auxguid.1

#### Git stuff ####
.PHONY: push
push:
	git push origin master

.PHONY: pull
pull:
	git pull origin master

.PHONY: gitstat
gitstat:
	git status --porcelain --branch

.PHONY: taglist
taglist:
	git tag --list

#### GitHub Release Stuff
.PHONY: show-next-release
show-next-release:
	@nr=`grep -E '^NEXTREL=' $(THISFILE)`; echo "$${nr##NEXTREL=}"

.PHONY: show-local-release-tags
show-local-release-tags:
	@git tag --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$$' | sort -V

.PHONY: show-remote-release-tags
show-remote-release-tags:
	@git ls-remote --tags origin | \
  grep -E 'refs/tags/[0-9]+\.[0-9]+\.[0-9]+$$' | \
  sed 's#^.*refs/tags/##' | \
  sort -V

.PHONY: clean-runtime-dist
clean-runtime-dist:
	rm -rf $(RUNTIMEDIR)
	rm  -f dist/$(RUNTIMEDIR).tar.gz

.PHONY: runtime-dist
runtime-dist: $(RUNTIMEDIR)/bin \
  $(RUNTIMEDIR)/share/man/man1 \
  $(RUNTIMEDIR)/share/html/man/man1 \
  $(RUNTIMEDIR)/README.md \
  $(RUNTIMEDIR)/LICENSE \
  dist/$(RUNTIME).tar.gz

$(RUNTIMEDIR)/bin: bin
	mkdir -p $@
	rm -f $@/*
	cp -a $</* $@/

$(RUNTIMEDIR)/share/man/man1: share/man/man1
	mkdir -p $@
	rm -f $@/*.1
	cp -a $</*.1 $@/

$(RUNTIMEDIR)/share/html/man/man1: share/html/man/man1
	mkdir -p $@
	rm -f $@/*.html
	cp -a $</*.html $@/

$(RUNTIMEDIR)/README.md : README.md
	cp -a $< $@

$(RUNTIMEDIR)/LICENSE : LICENSE
	cp -a $< $@

dist/$(RUNTIME).tar.gz : dist \
  $(RUNTIMEDIR)/bin \
  $(RUNTIMEDIR)/share/man/man1 \
  $(RUNTIMEDIR)/share/html/man/man1
	cd dist ; tar -cvzf $(RUNTIME).tar.gz $(RUNTIME)

dist :
	mkdir -p dist

.PHONY: list-runtime-dist
list-runtime-dist:
	tar -tvzf dist/$(RUNTIME).tar.gz

.PHONY: local-release-tag
local-release-tag:
	git tag $(NEXTREL)

.PHONY: push-release-tag
push-release-tag:
	git push origin $(NEXTREL)

#### Aggregate stuff ####

.PHONY: clean
clean: cleantest cleandocs

