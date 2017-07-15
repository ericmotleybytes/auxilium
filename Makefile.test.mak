###
# This file designed to be included by Makefile.
###

#### Testing stuff ####

#.PHONY: test
test: test/auxilium.taplog test/auxilium.tapchk

test/auxilium.taplog : bin/auxenv \
  bin/auxsource \
  bin/auxwhere \
  bin/auxalias \
  bin/auxchecktap \
  bin/auxguid \
  bin/auxilium \
  $(wildcard test/*.bash) \
  $(wildcard test/*.bats)
	cd test; bats -t . | tee auxilium.taplog

test/auxilium.tapchk : test/auxilium.taplog
	bin/auxchecktap $< > $@

.PHONY: checktest
checktest: test/auxilium.tapchk
	bin/auxchecktap $<

#### Cleaning test logs ####

.PHONY: cleantest
cleantest:
	rm -f test/auxilium.taplog
	rm -f test/auxilium.tapchk
