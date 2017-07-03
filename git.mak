# Development makefile for common git activity
THISFILE:=$(lastword $(MAKEFILE_LIST))

.PHONY: all
all: help

.PHONY: help
help:
	@echo "Common git actions:"
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
	git status --porcelain --branch

.PHONY: list
list:
	git tag --list
