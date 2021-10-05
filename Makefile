local:
	rm -rf ./_site
	rm -rf Gemfile.lock
	rm -rf .jekyll-metadata
	open http://localhost:4000
	docker run -d --rm -v $(PWD):/srv/jekyll -p "4000:4000" jekyll/jekyll:pages "jekyll serve --watch --drafts --force_polling"
