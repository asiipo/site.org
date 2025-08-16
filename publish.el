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
(setq org-babel-python-command (expand-file-name "./.venv/bin/python"))

;; Don't prompt before evaluating code blocks
(setq org-confirm-babel-evaluate nil)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "academic-site:main"
             :recursive t
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
       (list "academic-site" :components '("academic-site:main" "academic-site:static" "academic-site:cname"))
       ))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")

;;; publish.el ends here
