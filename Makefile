stop:
	docker stop jekyll || true
	docker rm jekyll || true

local: stop
	rm -rf ./_site
	rm -rf Gemfile.lock
	rm -rf .jekyll-metadata
	echo "open http://localhost:4000"
	docker run -it --rm -v $(PWD):/srv/jekyll -e DEBUG=true --publish [::1]:4000:4000 --name jekyll jekyll/jekyll:pages jekyll serve --watch --drafts --force_polling
