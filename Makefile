SHELL:=/bin/bash
BASEDIR=$(CURDIR)
OUTPUTDIR=docs
PUBLISHBRANCH=gh-pages
PROJECTNAME=yeeitsjulia.github.io

.PHONY: publish
publish: clean get_public generate

.PHONY: serve
serve:
	@echo "serve site locally"
	hugo server -D -p 1313

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
	rm -rf $(OUTPUTDIR)/*

.PHONY: generate
generate:
	@echo "generate static site"
	hugo --gc --minify

.PHONY: deploy
deploy:
	@echo "deploy generated static site"
	@cd $(BASEDIR)/$(OUTPUTDIR) && \
	git add -A && \
	git ci -m "deploy updated site" && \
	git push origin $(PUBLISHBRANCH)
