# Academic Website

A complete org-mode based academic website, built with Emacs org-publish and deployed to GitHub Pages.

## Structure

```
org/         # Source org files
static/      # Static assets (copied to public/static/)
public/      # Generated website (auto-created)

CNAME        # Custom domain
Makefile     # Build automation
publish.el   # Org-publish configuration
requirements.txt # Python dependencies
```

## Quick Start

1. **Customize content**: Edit files in `org/` directory with your information
2. **Add assets**: Replace placeholders in `static/` with your CV and photo
3. **Build**: `make build`
4. **Preview**: `make serve` (opens http://localhost:8000)
5. **Deploy**: Push to GitHub, enable Pages

## Building & Development

```bash
# Build the site
make build

# Serve locally with hot reload
make serve

# Clean build artifacts  
make clean

# Force complete rebuild
make rebuild

# Deploy to gh-pages branch (optional)
make deploy
```

## Dependencies

- **Emacs** with org-mode (for building)  
- **htmlize** package (auto-installed)
- **Python 3.9+** (for local preview server and interactive visualizations)

## Local Development Setup

### Required for Interactive Blog Content

The site includes interactive Python visualizations in blog posts. To enable these features:

```bash
# Create virtual environment (this will be auto-created by the build process)
python3 -m venv .venv
source .venv/bin/activate

# Install required Python dependencies
pip install -r requirements.txt

# Alternative: Install manually
pip install numpy plotly
```

**Note**: The build system (`publish.el`) will automatically use the virtual environment if it exists, otherwise it falls back to system Python. For GitHub Actions deployment, only system Python is used.