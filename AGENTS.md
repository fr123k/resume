# AGENTS.md — Project Analysis

## Overview

This repository is a **Jekyll-based static site** serving as a personal resume + portfolio website for **Frank Ittermann** (`fr123k` / `fr12k`). It is hosted via **GitHub Pages** at **[resume.fr123k.uk](https://resume.fr123k.uk)** (custom domain via `CNAME`).

The project is a heavily customized fork of [**jglovier/resume-template**](https://github.com/jglovier/resume-template) (MIT license, ~1.9k GitHub stars). The original template provided dummy "Springfield" content — this fork replaced all content with Frank's actual professional experience and overhauled the design into a custom "Hyde" narrative layout.

The site is published from the **`gh-pages`** branch; the current active development branch is **`add_flink_experience`**.

---

## Repository Structure

```
resume/
├── _config.yml                  # Site configuration (Jekyll core)
├── _layouts/
│   └── resume.html              # Main layout: hero + story blocks + print header + bottom sections
├── _includes/
│   ├── head.html                # <head>: Google Fonts (Inter + Open Sans), GA, favicon, viewport
│   ├── analytics.html           # Google Analytics gtag snippet (G-M265JH5QM2)
│   ├── sidebar.html             # Sidebar (no-print): avatar, social links, contact, tech tags, education, interests
│   ├── icon-links.html          # Social icon links for web (legacy, unused by main layout)
│   ├── print-social-links.html  # Social links for print/PDF
│   └── icons/                   # Individual SVG icon includes
│       ├── icon-github.html
│       ├── icon-linkedin.html
│       ├── icon-twitter.html
│       ├── icon-dribbble.html
│       ├── icon-facebook.html
│       ├── icon-instagram.html
│       ├── icon-goodreads.html
│       ├── icon-medium.html
│       ├── icon-website.html
│       ├── icon-pdf.html
│       └── icon-print.html
├── _data/                       # Structured YAML content (the actual resume data)
│   ├── experience.yml           # Work history — the primary content (10 roles)
│   ├── education.yml            # Diploma (HTW Berlin)
│   ├── skills.yml               # Skills (mentorship, architecture)
│   ├── interests.yml            # Hobbies (beach volleyball, science, books, leadership)
│   ├── principles.yml           # Personal working principles (inspired by Ray Dalio)
│   ├── links.yml                # Disabled (placeholder data from upstream)
│   ├── recognitions.yml         # Disabled (placeholder data from upstream)
│   ├── associations.yml         # Disabled (placeholder data from upstream)
│   └── projects.yml             # Disabled (placeholder data from upstream)
├── _sass/                       # SCSS partials
│   ├── _normalize.scss          # normalize.css v3.0.3
│   ├── _variables.scss          # Design tokens: colors, typography, layout
│   ├── _mixins.scss             # SCSS mixins (border-radius, transition, media queries, tag-pill, card)
│   ├── _base.scss               # Reset + base typography + selection color
│   ├── _layout.scss             # Legacy grid (unused by active layout)
│   ├── _resume.scss             # Legacy section-header + icon styles
│   ├── _hyde.scss               # ★ Main stylesheet: hero, nav, story blocks, bottom sections, responsive
│   ├── _custom.scss             # Minor overrides (zebra-stripe tech-band border)
│   └── _print.scss              # ★ Extensive print/PDF layout (A4, 11pt, Calibri)
├── css/
│   └── main.scss                # Entry point: imports all partials in order
├── index.html                   # Jekyll front matter → uses resume layout
├── images/
│   ├── logo_fr123k.png
│   └── logo_fr123k_transparent.png
├── _assets/                     # Original design source files (Sketch, SVG, AI)
│   ├── resume-web-template.sketch
│   ├── icons.ai
│   └── icons/
│       ├── icon-*.svg           # SVG source files (10 icons)
├── CNAME                        # Custom domain: resume.fr123k.uk
├── favicon.png                  # Favicon
├── Gemfile                      # Ruby deps: github-pages gem, webrick, wdm (Windows)
├── Dockerfile                   # Ruby 2.7 container for Jekyll
├── Makefile                     # Docker-based `make local` for local dev
├── .travis.yml                  # Legacy CI: Ruby 2.5, `jekyll build`
├── .bundle/config               # Bundler config (vendor/bundle path)
├── .claude/settings.local.json  # Claude MCP permissions (Playwright browser automation)
├── .dockerignore
├── .gitignore
├── README.md                    # Original upstream README (partially outdated)
├── AGENTS.md                    # This file
└── LICENSE                      # MIT (original copyright Joel Glovier)
```

---

## Technology Stack

| Layer              | Technology                                               |
|--------------------|----------------------------------------------------------|
| Static Site Gen.   | **Jekyll** 4.x (via the `github-pages` gem, which pins compatible versions) |
| Templating         | **Liquid** (Jekyll's built-in template engine)            |
| Markup             | HTML5 + schema.org microdata (ItemScope, ItemProp)       |
| Styling            | **SCSS** (compiled by Jekyll's built-in SASS converter)  |
| Fonts              | Google Fonts: **Inter** (body) + **Open Sans** (headings) |
| Analytics          | **Google Analytics** (tag: `G-M265JH5QM2`)              |
| Hosting            | **GitHub Pages** (custom domain via CNAME)               |
| CI (legacy)        | Travis CI (`.travis.yml` — Ruby 2.5, `jekyll build`)    |
| Local Dev Option 1 | `bundle exec jekyll serve` (native Ruby)                 |
| Local Dev Option 2 | Docker: `make local` (uses `jekyll/jekyll` image)        |
| Local Dev Option 3 | Docker: `docker build -t resume-template .` + run        |

---

## Layout & Design ("Hyde" Theme)

The custom theme is defined primarily in `_sass/_hyde.scss` — a full-page narrative resume design. The original upstream template's sidebar + content-column layout has been replaced with a single-column scrolling narrative.

### Hero Section (web only, `.hero`)
- Full-viewport-height dark background (`#1e293b` slate)
- Circular avatar (150×150) with teal border (`#0d9488`)
- Name in large bold Open Sans, multi-line title below
- Italic quote from `resume_header_intro`
- Experience summary line (`15+ years...`)
- Social icons row (GitHub ×2, LinkedIn, Goodreads, Website) — teal hover
- Conditional "Contact me" button (links to email)
- Animated scroll-down chevron indicator

### Sticky Section Nav (`.section-nav`)
- Sticky top bar appearing after hero scroll
- Links: **Experience**, **Skills**, **Principles**, **About**
- Uppercase, small font, underline-on-hover accent

### Experience Story Blocks (`.story-block`)
- Alternating white (`#fff`) / light gray (`#f8fafc`) backgrounds per role
- Each block: Company name + duration (right-aligned), position, summary paragraph, bullet-list projects
- **Tech band**: color-coded pill tags for Languages (indigo), Tools (teal), Infrastructure (amber), Frameworks (pink)
  - Tags extracted dynamically from `_data/experience.yml` arrays per role
- Max-width 900px, centered

### Bottom Sections (`.bottom-sections`)
- Three-column grid on dark slate background (`#1e293b`)
- Columns: **Skills**, **Principles** (nested rule tree), **Education + Interests**
- Responsive: collapses to single column at ≤768px

### Sidebar (`.sidebar`, no-print)
- Present in `_includes/sidebar.html` but appears as a right-hand sidebar only at wider viewports
- Contains: avatar, name/title, social links, contact info, Languages/Tools/Infrastructure tag clouds, Education, Interests
- Copyright footer with dynamic year

### Print/PDF Layout (`_print.scss`)
- Extensive `@media print` styles (A4 page size, 11pt base, Calibri font)
- Print-only header: name, title, contact info (email, website, LinkedIn), quote
- **Technical Experience Summary**: auto-generated grid listing all Languages, Tools, Infrastructure, Frameworks (extracted from all experience entries via Liquid)
- Story blocks flattened: no background, bottom-border separators, page-break-avoid via `.unbreakable`
- Tech tags rendered as inline comma-separated text with category prefixes (e.g. "Languages: Golang, Python")
- Bottom sections: black-on-white, compact, with page-break avoidance
- Print social links at the very bottom

### Responsive Breakpoints
- `_hyde.scss` uses `@media (max-width: 768px)` to collapse the bottom grid and adjust hero/story padding
- `_mixins.scss` provides `media_max`, `media_min`, `media_larger_than_mobile` (600px), `media_mobile` (≤600px) mixins

---

## Configuration (`_config.yml`)

Key settings:

| Setting | Value |
|---------|-------|
| `title` | "Software Enginneer Resume" (**typo**: "Enginneer") |
| `description` | "The Software Engineer job resume of Frank Ittermann." |
| `avatar` | GitHub avatar URL |
| `resume_name` | Frank Ittermann |
| `resume_title` | "Senior Platform Engineer / Senior Site Reliability Engineer / Senior Backend Engineer" |
| `resume_contact_email` | frank.ittermann@yahoo.com |
| `resume_header_intro` | "Everything seems to be impossible until it is accomplished." |
| `resume_header_contact_info` | "15+ years of software and system engineering experience." |
| `google_analytics` | `G-M265JH5QM2` |
| `resume_looking_for_work` | **Removed/blank** (no contact button shown) |
| **Enabled sections** | Experience, Skills, Education, Principles, Interests |
| **Disabled sections** | Projects, Recognition, Links, Associations |
| **Social links** | GitHub (`fr12k`, `fr123k`), LinkedIn, Goodreads, Website (`profile.fr123k.uk`) |

---

## Content Data (`_data/`)

### `experience.yml` — The Core Content

Frank's full career history, chronologically with most recent first. Each entry includes:
- `company`, `position`, `duration`
- `summary` (optional paragraph)
- `projects` (list of bullet-point descriptions, supports HTML links)
- `languages`, `tools`, `infrastructure`, `frameworks` (arrays for the tech-band display)

| Company | Role | Duration |
|---------|------|----------|
| **Flink SE** | Senior Platform Engineer | Mar 2023 – present |
| **Planetly GmbH** | Senior SRE | Feb 2022 – Feb 2023 |
| **Data4Life** | Team Lead / Senior SRE | Oct 2020 – Oct 2021 |
| **Data4Life** (formerly Gesundheitscloud) | Senior SRE | Jan 2020 – Oct 2020 |
| **Gesundheitscloud** | SRE | Jan 2018 – Dec 2019 |
| **Hasso-Plattner-Institute** | Senior DevOps Engineer | Sep 2017 – Dec 2017 |
| **QualityPark** | Senior Java Software Engineer | Apr 2015 – Aug 2017 |
| **ZAG Zeitarbeits-Gesellschaft GmbH** | Unskilled Laborer | Sep 2014 – Feb 2015 |
| **Self-employed** | Open Source Developer | Aug 2013 – Sep 2014 |
| **Deutsche Post AG** | Senior Java Software Developer | Mar 2013 – Aug 2013 |
| **Deutsche Telekom AG** | Software Developer | May 2007 – Feb 2013 |

**Tech diversity across all roles:**
- **Languages:** Golang, Python, Java, JavaScript, Scala, C++, C, C#, Bash, Yaml, Helm
- **Tools:** Terraform, Ansible, Argo CD, CircleCI, GitHub Actions, Jenkins, Travis CI, Packer, Vagrant, Vault, Temporal, SonarQube, Jira, Confluence, and many more
- **Infrastructure:** GCP, AWS, Azure, Azure Stack, OpenStack, Kubernetes, Docker, PostgreSQL, Oracle, Tomcat, nginx, Heroku
- **Frameworks:** AngularJS, Apache Jersey, JUnit, Apache Wicket, NodeJS

### `principles.yml`
Personal working principles inspired by Ray Dalio's "Principles":
- **Meeting:** Don't take colleagues' time for granted; be clear on purpose
- **Change:** Starts with yourself
- **Efficiency:** Break repeating cycles; focus on time/outcome ratio
- **Tools/People:** Tools serve people, not vice versa
- **Leadership:** Focus on others' growth; be authentic and lead by example

### Other data files
- `education.yml`: Diploma in Applied Computer Science, HTW Berlin (2001–2006)
- `skills.yml`: Mentorship, Software/System Architecture (verbose descriptions)
- `interests.yml`: Beach volleyball, science & technology, books, leadership
- `links.yml`, `recognitions.yml`, `associations.yml`, `projects.yml`: Placeholder data from the upstream template — all disabled in `_config.yml`

---

## Git History & Branches

| Branch | Description |
|--------|-------------|
| `gh-pages` | Main deployment branch (GitHub Pages publishes from this) |
| `add_flink_experience` | Current active development branch (ahead of `gh-pages`) |
| `remotes/origin/update-deps` | Dependency update branch |

**Recent significant commits (most recent first):**
1. `29e8f25` — `design: apply new modern design` (the current "Hyde" narrative redesign)
2. `3b97ff7` — `chore: Add Flink experience`
3. `53779e1` — `feat(print): print layout of experience lists`
4. `ac96a81` — `feat(tools): Remove outdated tools`
5. `91c3e92` — Add Planetly experience

The fork merged upstream changes a few times (dependabot security bumps for nokogiri, tzinfo, Docker support). The last upstream merge was `7786d0f`.

---

## Key Observations & Caveats

### Typo in Site Title
`_config.yml` line 2: `title: "Software Enginneer Resume"` — "Enginneer" should be "Engineer".

### Disabled Sections Still Ship Data
`links.yml`, `recognitions.yml`, `associations.yml`, and `projects.yml` still contain placeholder data from the upstream Springfield template. These are disabled via `_config.yml` flags but the files remain. They could be deleted.

### `README.md` Is Outdated
The README still references the original upstream template's dummy content and instructions. It mentions Homer J. Simpson (upstream used Lisa M. Simpson) and Springfield references.

### `.travis.yml` Is Legacy
Configured for Ruby 2.5 — GitHub Pages now uses its own build pipeline. Travis CI is no longer active. This file could be removed or updated.

### `_layout.scss` Is Unused
The legacy grid layout in `_layout.scss` is imported but not referenced by the active "Hyde" layout. It could be removed.

### `_resume.scss` Is Minimal
Contains only `.section-header` and `.icon`/`.logo` styles. Mostly relevant for print output.

### Two GitHub Accounts
Social links reference both `github.com/fr12k` and `github.com/fr123k` — these are two separate GitHub accounts belonging to Frank.

### Print Layout Sophistication
The print stylesheet (`_print.scss`) is unusually detailed for a Jekyll resume template. It dynamically aggregates all languages/tools/infrastructure across all roles into a compact technical summary grid — a non-trivial Liquid template feature.

### Local Development
- `make local` uses Docker with the `jekyll/jekyll` image (not the project's own `Dockerfile`)
- The project `Dockerfile` uses Ruby 2.7 with `bundle exec jekyll serve`
- The `.bundle/config` sets `BUNDLE_PATH: "_vendor/bundle"` (gitignored)

---

## AI / Agent Context

This project has a `.claude/settings.local.json` that grants Playwright browser automation permissions (navigate, click, screenshot, evaluate, run code). This suggests the project may be used with Claude's browser automation capabilities for testing or visual verification of the rendered site.

---

## Summary

A personalized Jekyll + GitHub Pages resume site for a Senior Platform/SRE engineer. The upstream template has been completely re-themed with a custom dark-hero narrative layout, sophisticated print/PDF output, and rich YAML-driven work history data. The design prioritizes clean typography (Inter + Open Sans), color-coded tech tags, responsive layout, and a polished print experience suitable for PDF export.
