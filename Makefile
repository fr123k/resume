# Build the project — prefer Docker, fall back to direct Jekyll build
build:
	@if docker info >/dev/null 2>&1; then \
		docker build -t resume .; \
	elif command -v bundle >/dev/null 2>&1; then \
		bundle exec jekyll build; \
	else \
		echo "Neither Docker nor bundler are available. Install the prerequisites:"; \
		echo "  1. Docker: https://docs.docker.com/get-docker/"; \
		echo "  2. Or run 'gem install bundler && bundle install && make serve'"; \
		exit 1; \
	fi

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
