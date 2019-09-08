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
	(org-babel-do-load-languages
	 'org-babel-load-languages
	 '((dot . t)
	   (shell . t)))

	(setq org-html-divs '((preamble "header" "preamble")
                      (content "main" "content")
                      (postamble "footer" "postamble"))
      org-html-container-element "section"
      org-html-metadata-timestamp-format "%Y-%m-%d"
      org-html-checkbox-type 'html
      org-html-html5-fancy t
      org-html-htmlize-output-type 'css
      org-html-head-include-default-style nil
      org-html-head-include-scripts t
      org-html-doctype "html5"
      org-html-home/up-format "%s\n%s\n")

	(setq orgweb-html-preamble
	  "<div class=\"header\">
         <div class=\"banner\">
           <a href=\"/\">蒋大培的博客 </a>
           <p class=\"subtitle\">何逊而今渐老，都忘却春风词笔。</p>
         </div>
         <nav class=\"nav\">
           <a href=\"/\">About</a>
           <a href=\"/cv.html\">CV</a>
           <a href=\"/projects.html\">Project</a>
           <a href=\"/articles/sitemap.html\">Blog</a>
         </nav>
       </div>")

	(setq orgweb-html-postamble
	  "<div class=\"site-info\">
         <p class=\"copyright\">Jiang Dapei • 2019</p>
         <p class=\"generator\">Proudly published with <a href=\"https://www.gnu.org/software/emacs/\">Emacs</a> and <a href=\"https://orgmode.org/\">Org Mode</a></p>
      </div>")

	(setq orgweb-head  "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>")
	
	(setq org-publish-project-alist
		  `(("home"
			 :base-directory ,my-site-project-path
			 :publishing-directory ,my-site-publish-path
			 :publishing-function org-html-publish-to-html
			 :html-head  ,orgweb-head
			 :html-preamble ,orgweb-html-preamble
			 :html-postamble ,orgweb-html-postamble)
			("articles"
			 :base-directory ,(concat my-site-project-path "articles")
			 :base-extension "org"
			 :publishing-directory ,(concat my-site-publish-path "articles")
			 :publishing-function org-html-publish-to-html
			 :recursive t
			 :auto-sitemap t
			 :makeindex t
			 :sitemap-title "Blog Posts"
			 :html-head  ,orgweb-head
			 :html-preamble ,orgweb-html-preamble
			 :html-postamble ,orgweb-html-postamble)
			("static"
			 :base-directory ,my-site-project-path
			 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
			 :publishing-directory ,my-site-publish-path
			 :recursive t
			 :publishing-function org-publish-attachment)
			("notebook" :components ("home" "articles" "static"))))))

(provide 'config-org)
