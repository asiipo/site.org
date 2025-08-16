# Academic Economics Website

A complete org-mode based academic website for economics PhD candidates on the job market, built with Emacs org-publish and deployed to GitHub Pages.

## Structure

```
org/                    # Source org files
├── index.org          # Homepage with profile and quick links
├── cv.org             # CV page with PDF download
├── research.org       # Job market paper, working papers, publications
├── teaching.org       # Teaching experience, materials, philosophy
├── contact.org        # Contact info with academic profiles
└── blog/              # Blog posts directory

static/                 # Static assets
├── css/site.css       # Clean academic styling
├── img/profile.jpeg   # Professional headshot
└── CV.pdf             # Downloadable CV

public/                # Generated website (auto-created)
├── index.html         # Built homepage
├── static/            # Copied static files
└── ...                # Other generated HTML files

CNAME                 # Custom domain
Makefile              # Build automation
publish.el            # Org-publish configuration
```

## Quick Start

1. **Customize content**: Edit files in `org/` directory with your information
2. **Add assets**: Replace placeholders in `static/` with your CV and photo
3. **Build**: `make build`
4. **Preview**: `make serve` (opens http://localhost:8000)
5. **Deploy**: Push to GitHub, enable Pages

## Customization

Replace these placeholders throughout the org files:

- `{{NAME}}` - Your full name
- `{{AFFILIATION}}` - University/institution
- `{{EMAIL_OBFUSCATED}}` - Your email (consider obfuscation)
- `{{GOOGLE_SCHOLAR_URL}}` - Your Google Scholar profile
- `{{GITHUB_URL}}` - Your GitHub profile  
- `{{LINKEDIN_URL}}` - Your LinkedIn profile
- `{{JMP_TITLE}}` - Job market paper title
- `{{JMP_PDF}}` - Job market paper filename

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
- **Python 3.9+** (for local preview server and mathematical visualizations)
- **Python packages**: `matplotlib`, `numpy`, `plotly`, `kaleido` (for org-babel Python execution)

## Local Development Setup

For Python visualizations in blog posts:

```bash
# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install Python dependencies
pip install matplotlib numpy plotly kaleido
```