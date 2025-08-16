# site.org

My personal webpage built with org-mode and GitHub Pages.

## Structure

- `index.org` - Main homepage
- `posts/` - Blog posts directory
- `style.css` - CSS styling
- `publish.el` - Emacs org-publish configuration
- `build.sh` - Build script
- `.github/workflows/build.yml` - GitHub Actions workflow

## Local Development

1. Make sure you have Emacs installed
2. Edit the org files (`index.org`, `posts/*.org`)
3. Run the build script:
   ```bash
   ./build.sh
   ```
4. Preview locally:
   ```bash
   python3 -m http.server 8000 --directory public
   ```

## Deployment

The site automatically builds and deploys to GitHub Pages when you push to the main branch.

## Customization

- Edit `index.org` for the homepage content
- Add new posts in the `posts/` directory
- Modify `style.css` for styling
- Update `publish.el` for advanced org-publish settings
