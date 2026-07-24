# Default target — shows available commands (safe when Docker/bundler unavailable)
.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo "  make build     — Build the Jekyll site (requires Docker or bundler)"
	@echo "  make local     — Run site locally via Docker"
	@echo "  make serve     — Run via bundler directly"
	@echo "  make stop      — Stop the Docker container"
	@echo "  make pdf       — Generate RESUME.pdf via weasyprint (requires pip install weasyprint)"
	@echo "  make pdf-all   — Build then generate PDF"

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

# Generate PDF via weasyprint
pdf:
	@if command -v weasyprint >/dev/null 2>&1; then \
		echo "Generating RESUME.pdf…"; \
		weasyprint _site/index.html RESUME.pdf; \
	else \
		echo "weasyprint is not installed. Install it with: pip install weasyprint"; \
		exit 1; \
	fi

# Build then generate PDF
pdf-all: build pdf

# Run via bundler directly (without Docker)
serve:
	bundle exec jekyll serve
