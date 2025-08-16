// Contact Banner Component
// Creates and manages the sticky contact banner

function createContactBanner() {
  const banner = document.createElement('div');
  banner.className = 'contact-banner';
  banner.id = 'contactBanner';
  
  banner.innerHTML = `
    <div class="contact-banner-content">
      <div class="contact-banner-info">
        <div class="contact-banner-item">
          📧 <a href="mailto:arttu.siipola@helsinki.fi">arttu.siipola@helsinki.fi</a>
        </div>
        <div class="contact-banner-item">
          🏛️ University of Helsinki
        </div>
        <div class="contact-banner-item">
          🔗 <a href="https://github.com/asiipo" target="_blank">GitHub</a>
        </div>
        <div class="contact-banner-item">
          📚 <a href="https://scholar.google.com" target="_blank">Google Scholar</a>
        </div>
      </div>
    </div>
  `;
  
  document.body.appendChild(banner);
}

// Initialize when DOM is loaded
document.addEventListener('DOMContentLoaded', createContactBanner);
