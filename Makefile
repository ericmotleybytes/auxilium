###
# Makefile for auxilium development sources
###
SYS_PREFIX=/usr/local
DEV_PREFIX=$(HOME)/local
DEV_PREFIX2=~/local
PREFIX=$(DEV_PREFIX)
CURDATE=$(shell date +%Y-%m-%d)
CURDATETIME=$(shell date +%Y-%m-%dT%H:%M:%S%z)
RELDATAFILE=data/releases.dat
RELLOGFILE=data/releases.log
THISREL=$(shell sbin/show-release)
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
	@echo "  make helpbuild     # help building/cleaning sources."
	@echo "  make helpinstall   # help install/uninstall."
	@echo "  make helpgit       # help common git tasks."
	@echo "  make helprel       # help common GitHub release tasks."

include Makefile.build.mak
include Makefile.test.mak
include Makefile.install.mak
include Makefile.git.mak
include Makefile.release.mak
