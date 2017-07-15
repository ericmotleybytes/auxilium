###
# This file designed to be included by Makefile.
###

#### install help stuff ####
.PHONY: helpinstall
helpinstall:
	@echo "Common installing usage:"
	@echo "  make install       # copy files to under $(DEV_PREFIX2)."
	@echo "  make sysinstall    # copy files to under $(SYS_PREFIX) as root."
	@echo "  make install PREFIX=<prefix> # custom copy files."
	@echo "Common uninstalling usage:"
	@echo "  make uninstall     # delete files installed under $(DEV_PREFIX2)."
	@echo "  make sysuninstall  # delete files installed under $(SYS_PREFIX) as root."
	@echo "  make uninstall PREFIX=<prefix> # custom uninstall files."

#### install stuff ####

.PHONY: sysinstall
sysinstall:
	@sudo $(MAKE) "$(THISFILE)" install PREFIX="$(SYS_PREFIX)"

.PHONY: install
install : installinfo \
  $(PREFIX)/bin \
  $(PREFIX)/bin/auxenv \
  $(PREFIX)/bin/auxsource \
  $(PREFIX)/bin/auxwhere \
  $(PREFIX)/bin/auxalias \
  $(PREFIX)/bin/auxchecktap \
  $(PREFIX)/bin/auxguid \
  $(PREFIX)/bin/auxilium \
  $(PREFIX)/share \
  $(PREFIX)/share/man \
  $(PREFIX)/share/man/man1 \
  $(PREFIX)/share/man/man1/auxenv.1 \
  $(PREFIX)/share/man/man1/auxsource.1 \
  $(PREFIX)/share/man/man1/auxwhere.1 \
  $(PREFIX)/share/man/man1/auxalias.1 \
  $(PREFIX)/share/man/man1/auxchecktap.1 \
  $(PREFIX)/share/man/man1/auxguid.1 \
  $(PREFIX)/share/man/man1/auxilium.1 \
  $(PREFIX)/share/html \
  $(PREFIX)/share/html/man \
  $(PREFIX)/share/html/man/man1 \
  $(PREFIX)/share/html/man/man1/auxenv.1.html \
  $(PREFIX)/share/html/man/man1/auxsource.1.html \
  $(PREFIX)/share/html/man/man1/auxwhere.1.html \
  $(PREFIX)/share/html/man/man1/auxalias.1.html \
  $(PREFIX)/share/html/man/man1/auxchecktap.1.html \
  $(PREFIX)/share/html/man/man1/auxguid.1.html \
  $(PREFIX)/share/html/man/man1/auxilium.1.html \
  $(PREFIX)/share/html/auxilium \
  $(PREFIX)/share/html/auxilium/index.html \
  $(PREFIX)/share/html/auxilium/auxilium-user-guide.html \
  $(PREFIX)/share/html/auxilium/auxilium-user-guide.pdf \
  installinfo2

.PHONY: installinfo
installinfo:
	@echo "[INFO: doing auxilium install under $(PREFIX) as user $$(whoami).]"

.PHONY: installinfo2
installinfo2:
	@echo "[INFO: Auxilium installed under $(PREFIX) as user $$(whoami).]"
	@fullprefix=$$(readlink -f $(PREFIX)) ; \
  curuser=$$(whoami) ; \
  rcfile=~/.bashrc; \
  if [ "$$curuser" == "root" ]; then rcfile=/etc/bashrc; fi ; \
  echo "[NOTE: We recommended adding \"source $$fullprefix/bin/auxalias\" to $$rcfile.]"

$(PREFIX)/bin:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/bin/auxenv : bin/auxenv
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/bin/auxsource : bin/auxsource
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/bin/auxwhere : bin/auxwhere
	cp -a "$<" "$@"
	chmod $(BINMODE) "$@"

$(PREFIX)/bin/auxalias : bin/auxalias
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/bin/auxchecktap : bin/auxchecktap
	cp -a "$<" "$@"
	chmod $(BINMODE) "$@"

$(PREFIX)/bin/auxguid : bin/auxguid
	cp -a "$<" "$@"
	chmod $(BINMODE) "$@"

$(PREFIX)/bin/auxilium : bin/auxilium
	cp -a "$<" "$@"
	chmod $(BINMODE) "$@"

$(PREFIX)/share:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/man:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/man/man1:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/man/man1/auxenv.1: share/man/man1/auxenv.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/man/man1/auxsource.1: share/man/man1/auxsource.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/man/man1/auxwhere.1: share/man/man1/auxwhere.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/man/man1/auxalias.1: share/man/man1/auxalias.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/man/man1/auxchecktap.1: share/man/man1/auxchecktap.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/man/man1/auxguid.1: share/man/man1/auxguid.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/man/man1/auxilium.1: share/man/man1/auxilium.1
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/html/man:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/html/man/man1:
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/html/man/man1/auxenv.1.html: share/html/man/man1/auxenv.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/man/man1/auxsource.1.html: share/html/man/man1/auxsource.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/man/man1/auxwhere.1.html: share/html/man/man1/auxwhere.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/man/man1/auxalias.1.html: share/html/man/man1/auxalias.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/man/man1/auxchecktap.1.html: share/html/man/man1/auxchecktap.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/man/man1/auxguid.1.html: share/html/man/man1/auxguid.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/man/man1/auxilium.1.html: share/html/man/man1/auxilium.1.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/auxilium :
	mkdir "$@"
	chmod $(DIRMODE) "$@"

$(PREFIX)/share/html/auxilium/index.html : \
  share/html/auxilium/index.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/auxilium/auxilium-user-guide.html : \
  share/html/auxilium/auxilium-user-guide.html
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

$(PREFIX)/share/html/auxilium/auxilium-user-guide.pdf : \
  share/html/auxilium/auxilium-user-guide.pdf
	cp -a "$<" "$@"
	chmod $(SRCMODE) "$@"

#### uninstall stuff ####

.PHONY: sysuninstall
sysuninstall:
	@sudo $(MAKE) $(THISFILE) uninstall PREFIX=$(SYS_PREFIX)

.PHONY: uninstall
uninstall:
	@echo "INFO: doing uninstall from $(PREFIX) as user $$(whoami)."
	rm -f $(PREFIX)/bin/auxenv
	rm -f $(PREFIX)/bin/auxsource
	rm -f $(PREFIX)/bin/auxwhere
	rm -f $(PREFIX)/bin/auxalias
	rm -f $(PREFIX)/bin/auxchecktap
	rm -f $(PREFIX)/bin/auxguid
	rm -f $(PREFIX)/bin/auxilium
	rm -f $(PREFIX)/share/man/man1/auxenv.1
	rm -f $(PREFIX)/share/man/man1/auxsource.1
	rm -f $(PREFIX)/share/man/man1/auxwhere.1
	rm -f $(PREFIX)/share/man/man1/auxalias.1
	rm -f $(PREFIX)/share/man/man1/auxchecktap.1
	rm -f $(PREFIX)/share/man/man1/auxguid.1
	rm -f $(PREFIX)/share/man/man1/auxilium.1
	rm -f $(PREFIX)/share/html/man/man1/auxenv.1
	rm -f $(PREFIX)/share/html/man/man1/auxsource.1
	rm -f $(PREFIX)/share/html/man/man1/auxwhere.1
	rm -f $(PREFIX)/share/html/man/man1/auxalias.1
	rm -f $(PREFIX)/share/html/man/man1/auxchecktap.1
	rm -f $(PREFIX)/share/html/man/man1/auxguid.1
	rm -f $(PREFIX)/share/html/man/man1/auxilium.1
	rm -f $(PREFIX)/share/html/auxilium/index.html
	rm -f $(PREFIX)/share/html/auxilium/auxilium-user-guide.html
	rm -f $(PREFIX)/share/html/auxilium/auxilium-user-guide.pdf
