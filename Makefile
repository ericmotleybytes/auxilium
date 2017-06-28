# Development Makefile for auxilium
DEFAULT_FINAL_PREFIX=/usr/local
DEFAULT_DEVEL_PREFIX=$(HOME)/local

.PHONY: all
all : help

#### Help stuff ####

.PHONY: help
help:
	@echo "Common building usage:"
	@echo "  make docs          # gen man and html documentation."
	@echo "  make test          # run tests and save result to logs."
	@echo "  make checktest     # check results in test logs."
	@echo "Common installing usage:"
	@echo "  make devinstall    # copy files to personal install area."
	@echo "  make install       # copy files to system dirs as root."
	@echo "Common cleanup usage:"
	@echo "  make cleantest     # copy test log files."
	@echo "  make cleandocs     # delete working copy of gen'd docs."
	@echo "  make cleanprefix   # delete saved prefix choices."
	@echo "Common uninstalling usage:"
	@echo "  make devuninstall  # delete files installed by devinstall."
	@echo "  make uninstall     # delete files installed by install as root."

#### Building stuff #####

.PHONY: docs
docs: man/auxenv.1 man/auxenv.1.html

man/auxenv.1 : man/auxenv.1.ronn
	cd man ; ronn --roff auxenv.1.ronn

man/auxenv.1.html : man/auxenv.1.ronn
	cd man ; ronn --html auxenv.1.ronn

#### Cleaning built stuff ####

.PHONY: cleandocs
cleandocs:
	rm -f man/auxenv.1
	rm -f man/auxenv.1.html

#### Testing stuff ####

.PHONY: test
test: test/test.log test/tap.log

test/test.log : bin/auxenv bin/auxsource
	cd test; bats -p . | tee test.log

test/tap.log : bin/auxenv bin/auxsource
	cd test; bats -t . | tee tap.log

.PHONY: checktest
checktest:
	@tail -n 1 test/test.log


#### Cleaning test logs ####

.PHONY: cleantest
cleantest:
	rm -f test/test.log
	rm -f test/tap.log

#### Installing stuff #####

devel.prefix :
	@def="$(DEFAULT_DEVEL_PREFIX)" ; \
         read -p "Enter development install prefix [$$def]: " prefix ; \
         prefix="$${prefix:-$$def}" ; \
         echo "$$prefix" > devel.prefix

devel.install.make : install.make.template devel.prefix
	prefix=`cat devel.prefix` ; \
         cat install.make.template | sed -e "s:<PREFIX>:$$prefix:g" > $@

.PHONY: devinstall
devinstall : devel.prefix devel.install.make
	make -f devel.install.make install

final.prefix :
	@def="$(DEFAULT_FINAL_PREFIX)" ; \
         read -p "Enter production install prefix [$$def]: " prefix ; \
         prefix="$${prefix:-$$def}" ; \
         echo "$$prefix" > final.prefix

final.install.make : install.make.template final.prefix
	prefix=`cat final.prefix` ; \
         cat install.make.template | sed -e "s:<PREFIX>:$$prefix:g" > $@

.PHONY: install
install : final.prefix final.install.make
	sudo make -f final.install.make install

#### Uninstalling stuff #####

.PHONY: devuninstall
devuninstall : devel.prefix devel.install.make
	make -f devel.install.make uninstall

.PHONY: uninstall
uninstall : final.prefix final.install.make
	sudo make -f final.install.make uninstall

.PHONY: cleanprefix
cleanprefix:
	rm -f devel.prefix
	rm -f final.prefix
	rm -f devel.install.make
	rm -f final.install.make

#### Aggregate stuff ####

.PHONY: clean
clean: cleanprefix cleantest cleandocs

#### git stuff ####

.PHONY: gitpush
gitpush:
	git push origin master
