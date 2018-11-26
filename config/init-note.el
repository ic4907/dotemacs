(require 'ox-html)
(require 'ox-publish)

(use-package htmlize
  :ensure t)

(setq org-project-base (concat (getenv "HOME") "/Documents/notes/"))
(setq org-project-publish-base (concat (getenv "HOME") "/Public/notes"))
;;(setq org-project-publish-base "/ssh:root@orgdown.com:/var/www/blog")

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
	(use-package ox-reveal)
	(setq org-src-fontify-natively t)
	(setq org-startup-indented t)

	(setq org-export-with-drawers t)

	(org-babel-do-load-languages
	 'org-babel-load-languages
	 '((dot . t)
	   (shell . t)))

	(setq org-use-fast-todo-selection t)

	(setq org-todo-keywords
		  '((sequence "TODO(t)" "DOING(i)" "|" "DONE(d)" "ABORT(a)")))

	(setq org-todo-keyword-faces '(("TODO" . "red")
								   ("DOING" . "yellow")
								   ("DONE" . "green")))

	(setq org-default-notes-file (concat org-project-base "gtd/inbox.org"))

	(setq org-agenda-files
		  (directory-files-recursively (concat org-project-base "gtd") "\.org$"))

	(defvar orgweb-html-preamble
	  "<div class='header'>
           <div class='left-items'>
               <a href='/'>Home</a>
               <a href='/about-me.html'>About Me</a>
               <a href='/sitemap.html'>Sitemap</a>
           </div>
           <div class='right-items'>
               <a href='https://www.linkedin.com/in/wang-yonggang-90a27499/' target='_blank'>Linkedin</a>
               <a href='https://github.com/ic4907' target='_blank'>Github</a>
           </div>
	  </div>
	  ")
	
	(setq org-publish-project-alist
		  `(
			("note"
			 :base-directory ,org-project-base
			 :base-extension "org"
			 :publishing-directory ,org-project-publish-base
			 :publishing-function org-html-publish-to-html
			 :with-author t
			 :with-email t
			 :with-creator t
			 :recursive t
			 :auto-sitemap t
			 :email "shalir@outlook.com"
			 :sitemap-filename "sitemap.org"
			 :html-doctype "html5"
			 :exclude "\\(thoughtworks\\|gtd\\)/.*"
			 :html-html5-fancy t
			 :html-head  "<link rel=\"stylesheet\" href=\"/css/ic4907.css\" type=\"text/css\"/>"
			 :html-preamble ,orgweb-html-preamble
			 :html-head-include-default-style nil)
			("note-static"
			 :base-directory ,org-project-base
			 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
			 :publishing-directory ,org-project-publish-base
			 :exclude "\\(thoughtworks\\|gtd\\)/.*"
			 :recursive t
			 :publishing-function org-publish-attachment)

			("note" :components ("note" "note-static"))))))

(provide 'init-note)
