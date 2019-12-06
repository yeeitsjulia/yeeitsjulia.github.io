SHELL:=/bin/bash
BASEDIR=$(CURDIR)
OUTPUTDIR=docs
PUBLISHBRANCH=gh-pages

.PHONY: publish
publish: clean get_public generate

.PHONY: serve
serve:
	@echo "serve site locally"
	hugo server -D

.PHONY: commit
commit:
	@echo "commit src files"

.PHONY: clean
clean:
	@echo "delete old publication"
	rm -rf $(BASEDIR)/$(OUTPUTDIR)
	git worktree prune

.PHONY: get_public
get_public:
	@echo "point $(OUTPUTDIR)/ to $(PUBLISHBRANCH) branch"
	git worktree add -B $(PUBLISHBRANCH) $(OUTPUTDIR) origin/$(PUBLISHBRANCH)
	@echo "remove existing files"
	rm -rf public/*

.PHONY: generate
generate:
	@echo "generate static site"
	hugo --gc --minify

.PHONY: deploy
deploy:
	@echo "deploy generated static site"
	@cd $(BASEDIR)/$(OUTPUTDIR)
	git add -A
	git ci -m "deploy updated site"
	git push git@github.com-yeeitsjulia:yeeitsjulia/yeeitsjulia.github.io.git $(PUBLISHBRANCH)
