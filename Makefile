# Makefile for Academic Website

# Default target
.PHONY: all build serve clean help

# Configuration
BUILD_DIR = public
ORG_DIR = org
STATIC_DIR = static
PORT = 8000

# Detect OS for sed compatibility
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    SED_INPLACE = sed -i ''
else
    SED_INPLACE = sed -i
endif

all: build

# Build the site
build:
	@echo "Building website..."
	@emacs --batch -l publish.el --eval "(org-publish-all t)"
	@echo "Post-processing HTML titles..."
	@for mapping in "cv:Curriculum Vitae:CV" "research:Research:Research" "teaching:Teaching:Teaching" "misc:Miscellaneous:Misc"; do \
		file=$$(echo $$mapping | cut -d: -f1); \
		original_title=$$(echo $$mapping | cut -d: -f2); \
		new_title=$$(echo $$mapping | cut -d: -f3); \
		$(SED_INPLACE) "s|<title>$$original_title</title>|<title>$$new_title \| Siipola</title>|g" $(BUILD_DIR)/$$file.html; \
	done
	@# Handle notes pages - make any title in blog/notes become "Notes | Siipola"
	@if [ -f "$(BUILD_DIR)/blog/2025-08-blog-test.html" ]; then \
		$(SED_INPLACE) 's|<title>[^<]*</title>|<title>Notes \| Siipola</title>|g' $(BUILD_DIR)/blog/2025-08-blog-test.html; \
	fi
	@if [ -f "$(BUILD_DIR)/notes/2025-08-blog-test.html" ]; then \
		$(SED_INPLACE) 's|<title>[^<]*</title>|<title>Notes \| Siipola</title>|g' $(BUILD_DIR)/notes/2025-08-blog-test.html; \
	fi
	@echo "Removing duplicate title tags (except index.html)..."
	@find $(BUILD_DIR) -name "*.html" ! -name "index.html" -exec $(SED_INPLACE) 's|<title>Arttu Siipola</title>||g' {} \;
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
