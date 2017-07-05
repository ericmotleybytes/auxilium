###
# This file designed to be included by Makefile.
###

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
	@echo "  make install       # copy files to under $(DEV_PREFIX)."
	@echo "  make sysinstall    # copy files to under $(SYS_PREFIX) as root."
	@echo "  make install PREFIX=<prefix> # custom copy files."
	@echo "Common uninstalling usage:"
	@echo "  make uninstall     # delete files installed under $(DEV_PREFIX)."
	@echo "  make sysuninstall  # delete files installed under $(SYS_PREFIX) as root."
	@echo "  make uninstall PREFIX=<prefix> # custom uninstall files."

#### Building stuff #####

.PHONY: build
build: docs
	@echo "[build complete]"

.PHONY: docs
docs: doc/README.md doc/README.txt \
  share/man/man1               share/html/man/man1 \
  share/man/man1/auxenv.1      share/html/man/man1/auxenv.1.html \
  share/man/man1/auxsource.1   share/html/man/man1/auxsource.1.html \
  share/man/man1/auxalias.1    share/html/man/man1/auxalias.1.html \
  share/man/man1/auxchecktap.1 share/html/man/man1/auxchecktap.1.html \
  share/man/man1/auxguid.1     share/html/man/man1/auxguid.1.html \
  share/man/man1/auxfixtexi.1  share/html/man/man1/auxfixtexi.1.html \
  share/html/auxilium.README.md.html

doc/README.md : doc/README.mdpp \
  doc/auxilium-general.mdpp \
  doc/install.mdpp doc \
  doc/install-runtime.mdpp \
  doc/install-sources.mdpp
	cd doc ; markdown-pp README.mdpp -o README.md

doc/README.txt : doc/README.md
	pandoc --from=markdown_github --to=plain --output="$@" "$<"

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

share/man/man1/auxfixtexi.1 : man/auxfixtexi.1.ronn
	ronn < $< > $@

share/html/man/man1/auxfixtexi.1.html : man/auxfixtexi.1.ronn
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
	rm -f share/man/man1/auxfixtexi.1
	rm -f share/html/man/man1/auxfixtexi.1.html
	rm -f share/html/auxilium.README.md.html

#### Aggregate stuff ####

.PHONY: clean
clean: cleantest cleandocs
