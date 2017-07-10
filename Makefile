###
# Makefile for auxilium development sources
###
SYS_PREFIX=/usr/local
DEV_PREFIX=$(HOME)/local
PREFIX=$(DEV_PREFIX)
CURDATE=`date +%Y-%m-%d`
RELDATAFILE=data/releases.dat
THISREL=`sbin/show-release --current`
RUNTIME=auxilium-run-$(THISREL)
DEVTIME=auxilium-dev-$(THISREL)
THISFILE:=$(lastword $(MAKEFILE_LIST))
BINMODE=a+r+x
SRCMODE=a+r-x
DIRMODE=a+r+x
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

include Makefile.build.mak
include Makefile.test.mak
include Makefile.install.mak
include Makefile.git.mak
include Makefile.release.mak
