###
# This file designed to be included by Makefile.
###

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
	@echo "  make runtime-test             # test distribution copy."
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
	@echo "Scripted Alternative:"
	@echo "  To make all this easier, you might want to consider using"
	@echo "  the 'sbin/do-release' script."

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
	rm  -f dist/$(RUNTIME).tar.gz
	rm -rf dist/$(RUNTIME)

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
  tar --exclude='$(RUNTIME)/test' --exclude='Makefile.test.mak' -czf $(RUNTIME).tar.gz $(RUNTIME)

.PHONY: list-runtime-dist
list-runtime-dist:
	tar -tvzf dist/$(RUNTIME).tar.gz

.PHONY: runtime-test
runtime-test:
	cd dist/$(RUNTIME); make -f Makefile.test.mak checktest

.PHONY: local-release-tag
local-release-tag:
	git tag $(NEXTREL)

.PHONY: push-release-tag
push-release-tag:
	git push origin $(NEXTREL)