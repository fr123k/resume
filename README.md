# Frank Ittermann — Resume

*A Jekyll + GitHub Pages powered resume site for [Frank Ittermann](https://resume.fr123k.uk).*

This is a heavily customized fork of [jglovier/resume-template](https://github.com/jglovier/resume-template). The original sidebar layout has been replaced with a custom single-column narrative design ("Hyde" theme) featuring a dark hero section, alternating story blocks, color-coded tech tags, and a sophisticated print/PDF stylesheet.

## Running locally

### With Ruby + Bundler

```bash
bundle install
bundle exec jekyll serve
# Open http://localhost:4000
```

### With Docker (recommended)

```bash
make build    # builds the Docker image (Ruby 3.3 + Jekyll 4.4)
make local    # runs the site at http://localhost:4000
```

## Project Structure

| Path | Description |
|------|-------------|
| `_config.yml` | Site configuration (name, title, social links, section toggles) |
| `_layouts/resume.html` | Main HTML layout |
| `_includes/` | Partials: head, sidebar, analytics, SVG icons |
| `_data/` | YAML content: experience, education, skills, principles, interests |
| `_sass/` | SCSS partials — the custom "Hyde" theme |
| `_sass/_hyde.scss` | Main stylesheet (hero, story blocks, tech bands, bottom sections) |
| `_sass/_print.scss` | Print/PDF layout (A4, 11pt Calibri) |
| `CNAME` | Custom domain: `resume.fr123k.uk` |

## Customizing

Edit `_config.yml` to change name, title, social links, and toggle sections on/off. Resume content lives in the `_data/` directory as structured YAML files.

## License

The code and styles are licensed under the MIT license. See [LICENSE](LICENSE).
