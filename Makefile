# Build the project Docker image (Ruby 3.3 + Jekyll 4.4)
build:
	docker build -t resume .

# Run the site locally via the project Dockerfile
local: stop
	rm -rf ./_site
	rm -rf Gemfile.lock
	rm -rf .jekyll-metadata
	docker run -d --rm -v $(PWD):/home/app --publish [::1]:4000:4000 -p 4000:4000 --name resume resume jekyll serve --watch --drafts --force_polling --host 0.0.0.0

stop:
	docker stop -t 30 resume || true
	docker rename resume resumeStopped || true

# Run via bundler directly (without Docker)
serve:
	bundle exec jekyll serve
