# Makefile for Academic Website

# Default target
.PHONY: all build serve clean help

# Configuration
BUILD_DIR = public
ORG_DIR = org
STATIC_DIR = static
PORT = 8000

all: build

# Build the site
build:
	@echo "Building academic website..."
	@emacs --batch -l publish.el --eval "(org-publish-all t)"
	@echo "✅ Build complete!"

# Serve locally for development
serve: build
	@echo "Starting local server at http://localhost:$(PORT)"
	@echo "Press Ctrl+C to stop"
	@python3 -m http.server $(PORT) --directory $(BUILD_DIR)

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	@rm -rf $(BUILD_DIR)/
	@rm -rf .packages/
	@echo "✅ Clean complete!"

# Force rebuild (clean + build)
rebuild: clean build

# Deploy to gh-pages branch (requires git setup)
deploy: build
	@echo "Deploying to gh-pages branch..."
	@if [ ! -d "$(BUILD_DIR)" ]; then echo "❌ No build directory found. Run 'make build' first."; exit 1; fi
	@git add $(BUILD_DIR) && git commit -m "Update site" || echo "No changes to commit"
	@git subtree push --prefix $(BUILD_DIR) origin gh-pages
	@echo "✅ Deployed to gh-pages!"

# Show help
help:
	@echo "Academic Website Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  build    - Build the website from org files"
	@echo "  serve    - Build and serve locally on port $(PORT)"
	@echo "  clean    - Remove build artifacts"
	@echo "  rebuild  - Clean and rebuild"
	@echo "  deploy   - Deploy to gh-pages branch"
	@echo "  help     - Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  make build"
	@echo "  make serve"
	@echo "  make deploy"
