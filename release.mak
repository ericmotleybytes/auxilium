# Development makefile for managing versioned releases
THISFILE:=$(lastword $(MAKEFILE_LIST))
GITMAK=git.mak

.PHONY: all
all: help

.PHONY: help
help:
	@echo "Before releasing checklist:"
	@echo "  make build     # make sure all software docs built."
	@echo "  make checktest # make sure all unit tests pass."
	@echo "
	
	@echo "Common release actions:"
	@echo "  make -f $(THISFILE) push    # git push origin master"
	@echo "  make -f $(THISFILE) pull    # git pull origin master"
	@echo "  make -f $(THISFILE) status  # git status --short --branch"
	@echo "  make -f $(THISFILE) list    # git tag --list"

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
