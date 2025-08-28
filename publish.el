;;; publish.el --- Org-mode publishing configuration

;;; Commentary:
;; This file contains the configuration for publishing org files to HTML
;; Run with: emacs --batch -l publish.el --eval "(org-publish-all t)"

;;; Code:

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

(require 'ox-publish)

;; Enable org-babel for code execution
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)
   (shell . t)
   (emacs-lisp . t)))

;; Configure Python executable for org-babel
;; Use system python in CI, local venv for development

;; Set Python command based on OS
(setq org-babel-python-command
      (if (eq system-type 'windows-nt)
          "python"
        (if (getenv "GITHUB_ACTIONS")
            "python3"
          (expand-file-name "./.venv/bin/python"))))

;; Don't prompt before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

;; Custom HTML templates for consistent sidebar
(defun academic-site-preamble (plist)
  "Generate the sidebar HTML preamble with mobile-friendly navigation."
  (let* ((file (plist-get plist :input-file))
         (output-file (plist-get plist :output-file))
         ;; Check if the output file will be in a subdirectory
         (is-subdir (string-match-p "/notes/" (or output-file file "")))
         (prefix (if is-subdir "../" "")))
    (format
     "<div class=\"sidebar\" id=\"sidebar\">
        <div class=\"sidebar-header\">
          <div class=\"sidebar-profile\">
            <img src=\"%sstatic/img/profile.jpeg\" alt=\"Arttu Siipola\" class=\"sidebar-photo\">
            <div>
              <h2 class=\"sidebar-name\">Arttu Siipola</h2>
              <p class=\"sidebar-title\">Doctoral Researcher in Economics</p>
              <p class=\"sidebar-affiliation\">University of Helsinki</p>
            </div>
          </div>
          
          <button class=\"nav-toggle\" onclick=\"toggleMobileNav()\" aria-label=\"Toggle navigation menu\">
            <div class=\"nav-toggle-icon\">
              <span></span>
              <span></span>
              <span></span>
            </div>
            Menu
          </button>
        </div>
        
        <nav class=\"sidebar-nav\" id=\"sidebar-nav\">
          <a href=\"%sindex.html\" class=\"nav-link\">Home</a>
          <a href=\"%sresearch.html\" class=\"nav-link\">Research</a>
          <a href=\"%scv.html\" class=\"nav-link\">CV</a>
          <a href=\"%steaching.html\" class=\"nav-link\">Teaching</a>
          <a href=\"%smisc.html\" class=\"nav-link\">Misc</a>
        </nav>
        
        <div class=\"sidebar-contact\">
          <div class=\"contact-item\">
            <svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\">
              <rect x=\"3\" y=\"5\" width=\"18\" height=\"14\" rx=\"2\" ry=\"2\"></rect>
              <path d=\"M3 7l9 6 9-6\"></path>
            </svg>
            <a href=\"mailto:arttu.siipola[at]helsinki[dot]fi\">Email</a>
          </div>
          <div class=\"contact-item\">
            <svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" fill=\"currentColor\">
              <path d=\"M12 2a10 10 0 0 0-3.16 19.49c.5.09.68-.22.68-.48 0-.24-.01-.87-.01-1.71-2.78.6-3.37-1.19-3.37-1.19-.45-1.16-1.11-1.47-1.11-1.47-.91-.62.07-.61.07-.61 1 .07 1.53 1.03 1.53 1.03 .9 1.53 2.36 1.09 2.94.84 .09-.66.35-1.09.63-1.34-2.22-.25-4.56-1.11-4.56-4.95 0-1.09.39-1.98 1.03-2.68-.1-.25-.45-1.27.1-2.64 0 0 .84-.27 2.75 1.02A9.57 9.57 0 0 1 12 6.84c.85 0 1.71.12 2.51.35 1.9-1.29 2.74-1.02 2.74-1.02 .55 1.37.2 2.39.1 2.64 .64.7 1.03 1.59 1.03 2.68 0 3.85-2.34 4.7-4.57 4.95 .36.31.68.92.68 1.86 0 1.34-.01 2.42-.01 2.75 0 .27.18.58.69.48A10 10 0 0 0 12 2z\"/>
            </svg>
            <a href=\"https://github.com/asiipo\" target=\"_blank\" rel=\"noopener\">GitHub</a>
          </div>
          <div class=\"contact-item\">
            <svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" fill=\"currentColor\">
              <path d=\"M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-4 0v7h-4v-7a6 6 0 0 1 6-6z\"/>
              <rect x=\"2\" y=\"9\" width=\"4\" height=\"12\"/>
              <circle cx=\"4\" cy=\"4\" r=\"2\"/>
            </svg>
            <a href=\"https://www.linkedin.com/in/arttu-siipola/\" target=\"_blank\" rel=\"noopener\">LinkedIn</a>
          </div>
          <div class=\"contact-item\">
            <svg viewBox=\"0 0 24 24\" aria-hidden=\"true\" fill=\"none\" stroke=\"currentColor\" stroke-width=\"2\" stroke-linecap=\"round\" stroke-linejoin=\"round\">
              <path d=\"M3 8l9-5 9 5-9 5-9-5z\"></path>
              <path d=\"M21 8v6\"></path>
              <path d=\"M12 13l-6-3v4a6 6 0 0 0 12 0v-4l-6 3z\"></path>
            </svg>
            <a href=\"https://scholar.google.com/citations?user=\" target=\"_blank\" rel=\"noopener\">Scholar</a>
          </div>
        </div>
      </div>
      
      <script>
        function toggleMobileNav() {
          const nav = document.getElementById('sidebar-nav');
          const button = document.querySelector('.nav-toggle');
          const icon = document.querySelector('.nav-toggle-icon');
          
          nav.classList.toggle('show');
          
          // Animate hamburger icon
          if (nav.classList.contains('show')) {
            icon.style.transform = 'rotate(90deg)';
            button.setAttribute('aria-expanded', 'true');
          } else {
            icon.style.transform = 'rotate(0deg)';
            button.setAttribute('aria-expanded', 'false');
          }
        }
        
        // Close mobile nav when clicking nav links
        document.addEventListener('DOMContentLoaded', function() {
          const navLinks = document.querySelectorAll('.nav-link');
          navLinks.forEach(link => {
            link.addEventListener('click', function() {
              const nav = document.getElementById('sidebar-nav');
              const button = document.querySelector('.nav-toggle');
              const icon = document.querySelector('.nav-toggle-icon');
              
              nav.classList.remove('show');
              icon.style.transform = 'rotate(0deg)';
              button.setAttribute('aria-expanded', 'false');
            });
          });
        });
      </script>"
     prefix prefix prefix prefix prefix prefix)))

(defun academic-site-postamble (plist)
  "Generate postamble with creator info."
  nil)  ; Return nil to use default org-mode creator display

(defun notes-site-preamble (plist)
  "Generate a clean preamble for notes pages without sidebar."
  (let* ((file (plist-get plist :input-file))
         (output-file (plist-get plist :output-file))
         ;; Check if the output file will be in a subdirectory
         (is-subdir (string-match-p "/notes/" (or output-file file "")))
         (prefix (if is-subdir "../" "")))
    (format
     "<div class=\"notes-header\">
        <div class=\"notes-nav\">
          <a href=\"%sindex.html\" class=\"notes-home-link\">← Back to Main Site</a>
          <div class=\"notes-title-section\">
            <h1 class=\"notes-site-title\">Arttu Siipola - Notes</h1>
            <p class=\"notes-subtitle\">Test window for notes</p>
          </div>
        </div>
      </div>"
     prefix)))

(defun notes-site-postamble (plist)
  "Generate postamble for notes with creator info."
  nil)  ; Return nil to use default org-mode creator display

;; Don't prompt before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "academic-site:main"
             :recursive nil  ; Don't recurse to avoid notes/
             :base-directory "./org/"
             :publishing-directory "./public/"
             :publishing-function 'org-html-publish-to-html
             :exclude "README\\.org"
             :with-author nil           ; Don't include author name
             :with-creator t            ; Include Emacs and Org versions
             :with-toc nil              ; Don't include a table of contents
             :section-numbers nil       ; Don't include section numbers
             :time-stamp-file nil       ; Don't include time stamp in file
             :html-validation-link nil  ; Don't include validation link
             :html-head-include-scripts nil ; Don't include scripts
             :html-head-include-default-style nil ; Don't include default style
             :html-doctype "html5"      ; Use HTML5
             :with-broken-links t       ; Allow placeholder links
             :auto-sitemap nil          ; Don't auto-generate sitemap (we have manual posts.org)
             :html-head-extra (concat
                   "<link rel=\"icon\" type=\"image/png\" href=\"static/img/uh-logo.png\" />"
                   "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"static/css/site.css\" />"
                   "\n<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>"
                   "\n<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>"
             )
             :html-preamble 'academic-site-preamble
             ;; Remove custom postamble to use default creator display
             )
       (list "academic-site:notes"
             :recursive t
             :base-directory "./org/notes/"
             :publishing-directory "./public/notes/"
             :publishing-function 'org-html-publish-to-html
             :with-author nil           ; Don't include author name
             :with-creator t            ; Include Emacs and Org versions
             :with-toc nil              ; Don't include a table of contents
             :section-numbers nil       ; Don't include section numbers
             :time-stamp-file nil       ; Don't include time stamp in file
             :html-validation-link nil  ; Don't include validation link
             :html-head-include-scripts nil ; Don't include scripts
             :html-head-include-default-style nil ; Don't include default style
             :html-doctype "html5"      ; Use HTML5
             :with-broken-links t       ; Allow placeholder links
             :auto-sitemap nil          ; Don't auto-generate sitemap
             :html-head-extra (concat
                   "<link rel=\"icon\" type=\"image/png\" href=\"../static/img/uh-logo.png\" />"
                   "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"../static/css/site.css\" />"
                   "\n<link rel=\"stylesheet\" type=\"text/css\" href=\"../static/css/notes-layout.css\" />"
                   "\n<script src=\"https://polyfill.io/v3/polyfill.min.js?features=es6\"></script>"
                   "\n<script id=\"MathJax-script\" async src=\"https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js\"></script>"
             )
             :html-preamble 'notes-site-preamble
             ;; Remove custom postamble to use default creator display
             )
       (list "academic-site:static"
             :base-directory "./static/"
             :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|pdf\\|txt"
             :publishing-directory "./public/static/"
             :recursive t
             :publishing-function 'org-publish-attachment
             )
       (list "academic-site:cname"
             :base-directory "./"
             :base-extension "CNAME"
             :publishing-directory "./public/"
             :publishing-function 'org-publish-attachment
             )
       (list "academic-site" :components '("academic-site:main" "academic-site:notes" "academic-site:static" "academic-site:cname"))
       ))

(message "Publishing configuration loaded!")

;;; publish.el ends here
