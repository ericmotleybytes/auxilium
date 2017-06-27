# Development Makefile for auxilium
DEFAULT_FINAL_PREFIX=/usr/local
DEFAULT_DEVEL_PREFIX=$(HOME)/local

all : test/test.log test/tap.log

test/test.log : bin/auxenv bin/auxsource
	cd test; bats -p . | tee test.log

test/tap.log : bin/auxenv bin/auxsource
	cd test; bats -t . | tee tap.log

.PHONY: install
install : final.prefix final.install.make
	sudo make -f final.install.make install

.PHONY: uninstall
uninstall : final.prefix final.install.make
	sudo make -f final.install.make uninstall

final.prefix :
	@def="$(DEFAULT_FINAL_PREFIX)" ; \
         read -p "Enter production install prefix [$$def]: " prefix ; \
         prefix="$${prefix:-$$def}" ; \
         echo "$$prefix" > final.prefix

final.install.make : install.make.template final.prefix
	prefix=`cat final.prefix` ; \
         cat install.make.template | sed -e "s:<PREFIX>:$$prefix:g" > $@

.PHONY: devinstall
devinstall : devel.prefix devel.install.make
	make -f devel.install.make install

.PHONY: devuninstall
devuninstall : devel.prefix devel.install.make
	make -f devel.install.make uninstall

devel.prefix :
	@def="$(DEFAULT_DEVEL_PREFIX)" ; \
         read -p "Enter development install prefix [$$def]: " prefix ; \
         prefix="$${prefix:-$$def}" ; \
         echo "$$prefix" > devel.prefix

devel.install.make : install.make.template devel.prefix
	prefix=`cat devel.prefix` ; \
         cat install.make.template | sed -e "s:<PREFIX>:$$prefix:g" > $@

.PHONY: clean
clean: cleanprefix
	rm -f test/test.log
	rm -f test/tap.log

.PHONY: cleanprefix
cleanprefix:
	rm -f devel.prefix
	rm -f final.prefix
	rm -f devel.install.make
	rm -f final.install.make

.PHONY: test
test:
	cd test ; bats .

.PHONY: tap
tap:
	cd test; bats -t .

.PHONY: checktest
checktest:
	@tail -n 1 test/test.log

.PHONY: gitpush
gitpush:
	git push origin master

.PHONE: showprefix
showprefix:
	@echo "DEFAULT_FINAL_PREFIX=$(DEFAULT_FINAL_PREFIX)"
	@echo "DEFAULT_DEVEL_PREFIX=$(DEFAULT_DEVEL_PREFIX)"
