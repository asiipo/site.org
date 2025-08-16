#!/bin/bash

# Build script for org-mode website
# This script uses Emacs to convert org files to HTML

set -e  # Exit on any error

echo "Building org-mode website..."

# Check if emacs is installed
if ! command -v emacs &> /dev/null; then
    echo "Error: Emacs is not installed. Please install Emacs to build the site."
    echo "On macOS: brew install emacs"
    echo "On Ubuntu: sudo apt-get install emacs-nox"
    exit 1
fi

# Clean previous build
echo "Cleaning previous build..."
rm -rf public/

# Run the publishing script
echo "Running org-publish..."
emacs --batch -l publish.el --eval "(org-publish-all t)" 2>&1

if [ $? -eq 0 ]; then
    echo "✅ Build complete! Site generated in public/ directory"
    echo "To preview locally, run: python3 -m http.server 8000 --directory public"
    echo "Then open: http://localhost:8000"
else
    echo "❌ Build failed!"
    exit 1
fi
