(require 'org)
(require 'ox-html)
(require 'ox-publish)
;;(require 'ox-rss)

(use-package htmlize
  :ensure t)

(setq my-site-project-path (concat (getenv "HOME") "/Documents/notes/"))
(setq my-site-publish-path (concat (getenv "HOME") "/Public/notes/"))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-capture
  :bind (("C-c c" . org-capture))
  :config
  (progn
	(setq org-capture-templates nil)))

(use-package org
  :bind (("C-c l" . org-store-link)
         ("C-c a" . org-agenda)
         ("C-c b" . org-iswitchb))
  :config
  (progn
	(use-package org-install)
	(use-package ox)
	(use-package org-archive)
	(setq org-src-fontify-natively t)
	(setq org-startup-indented t)
	(setq org-export-with-drawers t)
	(setq org-use-fast-todo-selection t)
	;; (setq org-default-notes-file (concat org-project-base "gtd/inbox.org"))
	;; (setq org-agenda-files
	;;	  (directory-files-recursively (concat org-project-base "gtd") "\.org$"))

	(org-babel-do-load-languages
	 'org-babel-load-languages
	 '((dot . t)
	   (shell . t)))

	(setq org-todo-keywords
		  '((sequence "TODO(t)" "DOING(i)" "|" "DONE(d)" "ABORT(a)")))

	(setq org-todo-keyword-faces '(("TODO" . "red")
								   ("DOING" . "yellow")
								   ("DONE" . "green")))

	(setq org-html-divs '((preamble "header" "top")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format "%Y-%m-%d"
      org-html-checkbox-type 'html
      org-html-html5-fancy t
      org-html-htmlize-output-type 'css
      org-html-head-include-default-style t
      org-html-head-include-scripts t
      org-html-doctype "html5"
      org-html-home/up-format "%s\n%s\n")

	(setq orgweb-html-preamble "<header id=\"top\" class=\"status\">
<h1 class=\"title\"><a href=\"/\">将大培的博客 </a>
  <p class=\"subtitle\">何逊而今渐老，都忘却春风词笔。</p>
</h1>
<nav>
  <a href=\"/\">About</a>
  <a href=\"/cv\">CV</a>
  <a href=\"/sitemap.html\">Blog</a>
</nav>
</header>")

	(setq orgweb-html-postamble "<div>
<p>Copyright 2019 by Jiang Dapei.
Proudly published with Emacs and Org mode
</div>")
	
	(setq org-publish-project-alist
		  `(
			("note"
			 :base-directory ,my-site-project-path
			 :base-extension "org"
			 :publishing-directory ,my-site-publish-path
			 :publishing-function org-html-publish-to-html
			 :with-author t
			 :with-email t
			 :with-creator t
			 :recursive t
			 :email "shalir@outlook.com"
			 :auto-sitemap t
			 :sitemap-filename "sitemap.org"
			 :html-doctype "html5"
			 :exclude "\\(thoughtworks\\|gtd\\)/.*"
			 :html-html5-fancy t
			 :html-head  "<link rel=\"stylesheet\" href=\"/css/ic4907.css\" type=\"text/css\"/>"
			 :html-preamble ,orgweb-html-preamble
			 :html-postamble ,orgweb-html-postamble
			 :html-head-include-default-style nil)
			("note-static"
			 :base-directory ,my-site-project-path
			 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
			 :publishing-directory ,my-site-publish-path
			 :exclude "\\(thoughtworks\\|gtd\\)/.*"
			 :recursive t
			 :publishing-function org-publish-attachment)

			("notebook" :components ("note" "note-static"))))))

(provide 'config-org)
