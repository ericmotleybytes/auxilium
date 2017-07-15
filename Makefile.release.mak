###
# This file designed to be included by Makefile.
###

.PHONY: helprel
helprel:
	@echo "Common Help for release actions:"
	@echo "  make helprel                  # display this screen."
	@echo "  make show-this-release        # version being built to be released next."
	@echo "  make show-remote-release-tags # release tags on GitHub server."
	@echo "  make show-local-release-tags  # release tags on local server."
	@echo "  make log-release-attempt      # log release attempt and datetime."
	@echo "  make stage-manuals            # stage manuals for upload to web."
	@echo "  make stage-readme             # stage README.md for upload to web."
	@echo "  make clean-runtime-dist       # clean distribution area."
	@echo "  make runtime-dist             # create distribution and tarball."
	@echo "  make runtime-test             # test distribution copy."
	@echo "  make list-runtime-dist        # list contents of dist tarball."
	@echo "  make local-release-tag        # tag files locally."
	@echo "  make push-release-tag         # tag files on remote."
	@echo "  make devtime-dist             # create dev  distribution and tarball."
	@echo "  make do-release               # run the full sbin/do-release script."
	@echo "Note:"
	@echo "  It is STRONGLY recommended to do releases via 'make do-release' or by"
	@echo "  executing the 'sbin/do-release' script (which is all 'make do-release'"
	@echo "  does anyway). From an interactive terminal this action is interactive."
	@echo "  The script displays critical information, makes checks, and prompts"
	@echo "  for user confirmation at key points in the release process."

.PHONY: do-release
do-release:
	sbin/do-release

#### GitHub Release Stuff
.PHONY: show-this-release
show-this-release:
	@echo "$(THISREL)"

.PHONY: show-local-release-tags
show-local-release-tags:
	@git tag --list | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$$' | sort -V

.PHONY: show-remote-release-tags
show-remote-release-tags:
	@git ls-remote --tags origin | \
  grep -E 'refs/tags/[0-9]+\.[0-9]+\.[0-9]+$$' | \
  sed 's#^.*refs/tags/##' | \
  sort -V

.PHONY: log-release-attempt
log-release-attempt:
	touch $(RELLOGFILE)
	echo "$(THISREL)|$(USER)|$(CURDATETIME)" >> $(RELLOGFILE)

.PHONY: stage-manuals
stage-manuals: docs/auxilium-user-guide.html \
  docs/auxilium-user-guide.pdf \
  docs/auxilium-dev-guide.html \
  docs/auxilium-dev-guide.pdf \
  docs/index.html
	@echo "[Manuals staged.]"

docs/auxilium-user-guide.html : share/html/auxilium/auxilium-user-guide.html
	cp $< $@

docs/auxilium-user-guide.pdf : share/html/auxilium/auxilium-user-guide.pdf
	cp $< $@

docs/auxilium-dev-guide.html : share/html/auxilium/auxilium-dev-guide.html
	cp $< $@

docs/auxilium-dev-guide.pdf : share/html/auxilium/auxilium-dev-guide.pdf
	cp $< $@

docs/index.html : doc/docs/index.html
	cp $< $@

.PHONY: stage-readme
stage-readme: README.md
	@echo "[README.md staged.]"

README.md : doc/readme/README.md
	cp $< $@

.PHONY: runtime-dist
runtime-dist: \
  dist/$(RUNTIME) \
  stage-runtime-dist \
  dist/$(RUNTIME)/Makefile \
  dist/$(RUNTIME)/Makefile.install.mak \
  dist/$(RUNTIME)/Makefile.test.mak \
  dist/$(RUNTIME)/LICENSE \
  dist/$(RUNTIME)/test \
  dist/$(RUNTIME).tar.gz

dist/$(RUNTIME):
	mkdir "$@"
	chmod $(DIRMODE) "$@"

.PHONY: stage-runtime-dist
stage-runtime-dist:
	$(MAKE) -f $(THISFILE) install PREFIX="dist/$(RUNTIME)"

dist/$(RUNTIME)/Makefile : dist/Makefile.run
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

dist/$(RUNTIME)/Makefile.install.mak : Makefile.install.mak
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

dist/$(RUNTIME)/Makefile.test.mak : Makefile.test.mak
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

dist/$(RUNTIME)/LICENSE : LICENSE
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

dist/$(RUNTIME)/test:
	cd "dist/$(RUNTIME)" ; cp -a "../../test" . ; rm -f test/auxilium.tap*

dist/$(RUNTIME).tar.gz : dist \
  dist/$(RUNTIME)/bin \
  dist/$(RUNTIME)/share/man/man1 \
  dist/$(RUNTIME)/share/html/man/man1
	cd dist ; \
  tar --exclude='$(RUNTIME)/test' --exclude='Makefile.test.mak' \
    -czf $(RUNTIME).tar.gz $(RUNTIME)

.PHONY: list-runtime-dist
list-runtime-dist:
	tar -tvzf dist/$(RUNTIME).tar.gz

.PHONY: runtime-test
runtime-test:
	cd dist/$(RUNTIME); make -f Makefile.test.mak checktest

.PHONY: local-release-tag
local-release-tag:
	git tag $(THISREL)

.PHONY: push-release-tag
push-release-tag:
	git push origin $(THISREL)

.PHONY: devtime-dist
devtime-dist: dist/$(DEVTIME).tar.gz

dist/$(DEVTIME).tar.gz : dist/$(DEVTIME)/README.md
	cd dist; tar -czf $(DEVTIME).tar.gz $(DEVTIME)

dist/$(DEVTIME)/README.md : dist/$(DEVTIME)
	cd dist/$(DEVTIME) ; \
          tar --strip-components=1 -xzf ../$(THISREL).tar.gz

dist/$(DEVTIME) : dist/$(THISREL).tar.gz
	mkdir -p "$@"

dist/$(THISREL).tar.gz :
	cd dist; wget https://github.com/ericmotleybytes/auxilium/archive/$(THISREL).tar.gz

.PHONY: clean-runtime-dist
clean-runtime-dist:
	rm  -f dist/$(RUNTIME).tar.gz
	rm -rf dist/$(RUNTIME)
	rm  -f dist/$(DEVTIME).tar.gz
	rm  -f dist/$(THISREL).tar.gz
	rm -rf dist/$(DEVTIME)
