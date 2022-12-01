OPEN=$(shell grep alias\ open= ~/.bashrc | awk -F"'" '{print $$2}')

stop:
	docker stop -t 30 jekyll || true
	docker rename jekyll jekyllStopped || true

local: stop
	rm -rf ./_site
	rm -rf Gemfile.lock
	rm -rf .jekyll-metadata
	$(OPEN) http://localhost:4000
	docker run -d --rm -v $(PWD):/srv/jekyll -e DEBUG=true --publish [::1]:4000:4000 --name jekyll jekyll/jekyll:pages jekyll serve --watch --drafts --force_polling
