# Development makefile for managing versioned releases
THISFILE:=$(lastword $(MAKEFILE_LIST))
NEXTREL=0.1.1
GITMAK=git.mak
RUNTIME=auxilium-runtime-$(NEXTREL)
RUNTIMEDIR=dist/$(RUNTIME)

.PHONY: all
all: help

.PHONY: help
help:
	@echo "Before releasing checklist:"
	@echo "  make build     # make sure all software docs built."
	@echo "  make checktest # make sure all unit tests pass."
	@echo "  make -f $(GITMAK) status # look for clean status."
	@echo "    # make sure all proper 'git add <file>' commands issued"
	@echo "    # make sure all proper 'git commit ...' commands issued."
	@echo "  make -f $(GITMAK) pull # pull down any remote changes made since your pull."
	@echo "  make -f $(GITMAK) status # look for clean status again."
	@echo "  make -f $(GITMAK) push   # do a normal push to the remote."
	@echo "Common release actions:"
	@echo "  # View previous release tags on remote..."
	@echo "    make -f $(GITMAK) show-remote-release-tags"
	@echo "      # if you see a remote release tag that WAS NOT ACTUALLY RELEASED,"
	@echo "      # you might want to (but probably should not) delete the remote tag."
	@echo "        git push --delete origin <release-tag>"
	@echo "      # decide what the new next release version should be and remember it."
	@echo "  # View existing local release tags..."
	@echo "    make -f $(GITMAK) show-local-release-tags"
	@echo "      # Make sure the new next release version not already been used."
	@echo "      # If you really want to reuse a version which is only locally tagged,"
	@echo "      # you could delete the old tag definition tag locally."
	@echo "        git tag --delete <release-tag>."
	@echo "  # View the currently configured next release version number."
	@echo "  # Edit $(THISFILE) and find the 'NEXTREL=...' line towards the top."
	@echo "  # Edit/change this release version to the new release version you picked."
	@echo "  # Save the edited file."
	@echo "  # Verify your change:"
	@echo "    make -f $(GITMAK) show-next-release."
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

.PHONY: push
push:
	git push origin master

.PHONY: pull
pull:
	git pull origin master

.PHONY: status
status:
	git status --short --branch

.PHONY: list
list:
	git tag --list

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

dist/$(RUNTIME).tar.gz : dist \
  $(RUNTIMEDIR)/bin \
  $(RUNTIMEDIR)/share/man/man1 \
  $(RUNTIMEDIR)/share/html/man/man1
	cd dist ; tar -cvzf $@ $(RUNTIME)

dist :
	mkdir -p dist

.PHONY: list-runtime-dist
list-runtime-dist:
	tar -tvzf dist/$(RUNTIME).tar.gz

.PHONY: local-release-tag
tag-local:
	git tag $(NEXTREL)

.PHONY: push-release-tag
	git push origin $(NEXTREL)
