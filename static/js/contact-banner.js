// Tiny helpers to keep HTML readable
const icn = {
  mail: `
    <svg viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <rect x="3" y="5" width="18" height="14" rx="2" ry="2"></rect>
      <path d="M3 7l9 6 9-6"></path>
    </svg>`,
  building: `
    <svg viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <path d="M3 21h18"></path>
      <path d="M6 21V7a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v14"></path>
      <path d="M9 10h.01M12 10h.01M15 10h.01M9 13h.01M12 13h.01M15 13h.01M9 16h6"></path>
    </svg>`,
  github: `
    <svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor">
      <path d="M12 2a10 10 0 0 0-3.16 19.49c.5.09.68-.22.68-.48
      0-.24-.01-.87-.01-1.71-2.78.6-3.37-1.19-3.37-1.19-.45-1.16-1.11-1.47-1.11-1.47-.91-.62.07-.61.07-.61
      1 .07 1.53 1.03 1.53 1.03 .9 1.53 2.36 1.09 2.94.84 .09-.66.35-1.09.63-1.34-2.22-.25-4.56-1.11-4.56-4.95
      0-1.09.39-1.98 1.03-2.68-.1-.25-.45-1.27.1-2.64 0 0 .84-.27 2.75 1.02A9.57 9.57 0 0 1 12 6.84
      c.85 0 1.71.12 2.51.35 1.9-1.29 2.74-1.02 2.74-1.02 .55 1.37.2 2.39.1 2.64 .64.7 1.03 1.59 1.03 2.68
      0 3.85-2.34 4.7-4.57 4.95 .36.31.68.92.68 1.86 0 1.34-.01 2.42-.01 2.75 0 .27.18.58.69.48A10 10 0 0 0 12 2z"/>
    </svg>`,
  scholar: `
    <svg viewBox="0 0 24 24" aria-hidden="true" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
      <!-- graduation cap -->
      <path d="M3 8l9-5 9 5-9 5-9-5z"></path>
      <path d="M21 8v6"></path>
      <path d="M12 13l-6-3v4a6 6 0 0 0 12 0v-4l-6 3z"></path>
    </svg>`
,
  linkedin: `
    <svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor">
      <path d="M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-4 0v7h-4v-7a6 6 0 0 1 6-6z"/>
      <rect x="2" y="9" width="4" height="12"/>
      <circle cx="4" cy="4" r="2"/>
    </svg>`
};

function createContactBanner() {
  const banner = document.createElement('div');
  banner.className = 'contact-banner';
  banner.id = 'contactBanner';
  
  banner.innerHTML = `
    <div class="contact-banner-content" role="contentinfo">
      <div class="contact-banner-info">
        <div class="contact-banner-item">
          ${icn.mail}
          <a href="mailto:arttu.siipola@helsinki.fi" aria-label="Email Arttu">arttu.siipola@helsinki.fi</a>
        </div>
        <div class="contact-banner-item" aria-label="Affiliation">
          ${icn.building}
          <span>University of Helsinki</span>
        </div>
        <div class="contact-banner-item">
          ${icn.github}
          <a href="https://github.com/asiipo" target="_blank" rel="noopener">GitHub</a>
        </div>
        <div class="contact-banner-item">
          ${icn.linkedin}
          <a href="https://www.linkedin.com/in/arttu-siipola/" target="_blank" rel="noopener">LinkedIn</a>
        </div>
        <div class="contact-banner-item">
          ${icn.scholar}
          <a href="https://scholar.google.com/citations?user=" target="_blank" rel="noopener">Google Scholar</a>
        </div>
      </div>
    </div>
  `;
  
  document.body.appendChild(banner);
}

function createNavigation() {
  const nav = document.createElement('nav');
  nav.className = 'top-nav';
  
  // Detect if we're in a subdirectory
  const isInSubdir = window.location.pathname.includes('/blog/') || window.location.pathname.includes('/notes/');
  const prefix = isInSubdir ? '../' : '';
  
  nav.innerHTML = `
    <a href="${prefix}index.html">Home</a>
    <a href="${prefix}cv.html">CV</a>
    <a href="${prefix}research.html">Research</a>
    <a href="${prefix}teaching.html">Teaching</a>
    <a href="${prefix}misc.html">Misc</a>
  `;
  
  // Insert navigation after the title (h1.title) or after the first h1 if no .title class
  const titleElement = document.querySelector('h1.title') || document.querySelector('h1');
  if (titleElement) {
    titleElement.parentNode.insertBefore(nav, titleElement.nextSibling);
  } else {
    // Fallback: insert at the beginning of main content or body
    const mainContent = document.querySelector('main') || document.querySelector('#content') || document.body;
    const firstElement = mainContent.firstElementChild;
    if (firstElement) {
      mainContent.insertBefore(nav, firstElement);
    } else {
      mainContent.appendChild(nav);
    }
  }
}

function moveCreatorToBanner() {
  // Org exports the version info as <p class="creator"> inside <div id="postamble">
  const creator = document.querySelector('.creator');
  const banner = document.getElementById('contactBanner');
  if (creator && banner) {
    creator.classList.add('creator-in-banner');
  // Restore original single-line creator info
    banner.appendChild(creator);
    // Optionally hide the postamble container if empty
    const postamble = document.getElementById('postamble');
    if (postamble && postamble.childElementCount === 1) {
      postamble.style.display = 'none';
    }
  }
}

document.addEventListener('DOMContentLoaded', function() {
  createNavigation();
  createContactBanner();
  moveCreatorToBanner();
});
