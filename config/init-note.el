(require 'ox-html)
(require 'ox-publish)

(use-package htmlize
  :ensure t)

(setq org-mode-websrc-directory (concat (getenv "HOME") "/Documents/notes/"))
(setq org-mode-publishing-directory (concat (getenv "HOME") "/Public/notes"))
;;(setq org-mode-publishing-directory "/ssh:root@orgdown.com:/var/www/blog")

(use-package ox-reveal
  :defer t
  :config
  (progn
    (setq org-reveal-root "http://cdn.jsdelivr.net/reveal.js/2.5.0/")))

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb)
         ("C-c c" . org-capture)
         ("C-c M-p" . org-babel-previous-src-block)
         ("C-c M-n" . org-babel-next-src-block)
         ("C-c S" . org-babel-previous-src-block)
         ("C-c s" . org-babel-next-src-block))
  :config
  (progn
	(use-package org-install)
	(use-package ox)
	(use-package org-archive)
	(setq org-src-fontify-natively t)
	(setq org-publish-project-alist
		  `(
			("note"
			 :base-directory ,org-mode-websrc-directory
			 :base-extension "org"
			 :publishing-directory ,org-mode-publishing-directory
			 :publishing-function org-html-publish-to-html
			 :with-toc nil
			 :with-author t
			 :with-email t
			 :html-use-infojs t
			 :recursive t
			 :auto-sitemap t
			 :sitemap-title "蒋大培的笔记"
			 :email "shalir@outlook.com"
			 :sitemap-filename "index.org"
			 :html-doctype "html5"
			 :exclude "thoughtworks/*"
			 :html-html5-fancy t
			 :html-head  "<link rel=\"stylesheet\" href=\"css/normalize.css\" type=\"text/css\"/>"
			 :html-head-include-default-style nil)
			("note-static"
			 :base-directory ,org-mode-websrc-directory
			 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
			 :publishing-directory ,org-mode-publishing-directory
			 :recursive t
			 :publishing-function org-publish-attachment)

			("note" :components ("note" "note-static"))))))

(provide 'init-note)
