#!/bin/bash

# Build script for org-mode website
# This script uses Emacs to convert org files to HTML

echo "Building org-mode website..."

# Check if emacs is installed
if ! command -v emacs &> /dev/null; then
    echo "Error: Emacs is not installed. Please install Emacs to build the site."
    exit 1
fi

# Clean previous build
rm -rf public/

# Run the publishing script
emacs --batch -l publish.el --eval "(org-publish-all t)"

echo "Build complete! Site generated in public/ directory"
echo "To preview locally, run: python3 -m http.server 8000 --directory public"
