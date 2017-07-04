###
# This file designed to be included by Makefile.
###

.PHONY: helpgit
helpgit:
	@echo "Common git actions:"
	@echo "  make helpgit     # display this screen."
	@echo "  make push        # git push origin master"
	@echo "  make pull        # git pull origin master"
	@echo "  make gitstat     # git status --porcelain --branch"
	@echo "  make taglist     # git tag --list"
	@echo "  make show-branch # show git branch"

#### Git stuff ####
.PHONY: push
push:
	git push origin master

.PHONY: pull
pull:
	git pull origin master

.PHONY: gitstat
gitstat:
	git status --porcelain --branch

.PHONY: taglist
taglist:
	git tag --list

.PHONY: show-branch
show-branch:
	@git status | head -1 | sed 's/#\ On\ branch\ //'
