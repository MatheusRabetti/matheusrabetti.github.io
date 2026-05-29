# matheusrabetti.github.io

Personal website and blog for **Matheus Rabetti** — Senior Data Scientist specializing in causal inference, experimentation, and marketing measurement.

Live at: [matheusrabetti.github.io](https://matheusrabetti.github.io)

Built with [Jekyll](https://jekyllrb.com/) and the [Minimal Mistakes](https://mmistakes.github.io/minimal-mistakes/) theme, hosted on GitHub Pages.

---

## Running locally

### Prerequisites

- [rbenv](https://github.com/rbenv/rbenv) (recommended) or another Ruby version manager
- Ruby 3.2.0
- Bundler

### Setup

```bash
# Install Ruby 3.2.0 via rbenv (first time only)
rbenv install 3.2.0
rbenv local 3.2.0

# Verify rbenv shims are active
ruby --version   # should print ruby 3.2.x

# Install Bundler and project dependencies
gem install bundler
bundle install
```

### Start the dev server

```bash
bundle exec jekyll serve
```

Open [http://localhost:4000](http://localhost:4000) in your browser.

> **Note:** `_config.yml` changes are not hot-reloaded. Restart the server after editing that file.

---

## Project structure

| Path | Purpose |
|------|---------|
| `_config.yml` | Site settings, author profile, Jekyll plugins |
| `_pages/` | Static pages (About, etc.) |
| `_posts/` | Blog posts in Markdown |
| `assets/` | Images, JS, CSS |
| `_sass/` | Theme style overrides |

---

## Deployment

Pushes to `master` are automatically deployed via GitHub Pages. No build step required.
