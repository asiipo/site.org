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

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./"
             :publishing-directory "./public/"
             :publishing-function 'org-html-publish-to-html
             :exclude "README\\.org\\|build\\.sh\\|publish\\.el\\|\\.packages\\|public/"
             :with-author nil           ; Don't include author name
             :with-creator t            ; Include Emacs and Org versions
             :with-toc nil              ; Don't include a table of contents
             :section-numbers nil       ; Don't include section numbers
             :time-stamp-file nil       ; Don't include time stamp in file
             :html-validation-link nil  ; Don't include validation link
             :html-head-include-scripts nil ; Don't include scripts
             :html-head-include-default-style nil ; Don't include default style
             :auto-sitemap t            ; Generate sitemap
             :sitemap-filename "sitemap.org"
             :sitemap-title "Site Map"
             )
       (list "org-site:static"
             :base-directory "./"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|txt"
             :publishing-directory "./public/"
             :recursive t
             :publishing-function 'org-publish-attachment
             :exclude "public/"
             )
       (list "org-site" :components '("org-site:main" "org-site:static"))
       ))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")

;;; publish.el ends here
