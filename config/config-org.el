(require 'org)
(require 'ox-html)
(require 'ox-publish)
;;(require 'ox-rss)

;; (use-package htmlize
;;   :ensure t)

(setq blog-source-folder (concat (getenv "HOME") "/Documents/blog/"))
(setq blog-target-folder (concat (getenv "HOME") "/Public/blog/"))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package org-capture
  :bind (("C-c c" . org-capture))
  :config
  (progn
	(setq org-capture-templates nil)))

(use-package graphviz-dot-mode
  :ensure t)

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

	(add-to-list 'org-src-lang-modes (quote ("dot" . graphviz-dot)))

	(setq org-html-divs '((preamble "header" "preamble")
						  (content "main" "content")
						  (postamble "footer" "postamble"))
		  org-html-container-element "section"
		  org-html-metadata-timestamp-format "%Y-%m-%d"
		  org-html-checkbox-type 'html
		  org-html-html5-fancy t
		  org-html-head-include-default-style nil
		  org-html-head-include-scripts t
		  org-html-doctype "html5"
		  org-html-home/up-format "%s\n%s\n")

	(setq blog-html-preamble
		  "<div class=\"header\">
         <div class=\"banner\">
           <a href=\"/\">蒋大培的博客 </a>
           <p class=\"subtitle\">爱技术，喜欢计算机编程。</p>
         </div>
         <nav class=\"nav\">
           <a href=\"/\">About</a>
           <a href=\"/cv.html\">CV</a>
           <a href=\"/projects/\">Project</a>
           <a href=\"/articles/sitemap.html\">Blog</a>
         </nav>
       </div>")

	(setq blog-html-postamble
		  "<div class=\"site-info\">
         <p class=\"copyright\">Jiang Dapei • 2019</p>
         <p class=\"generator\">Proudly published with <a href=\"https://www.gnu.org/software/emacs/\">Emacs</a> and <a href=\"https://orgmode.org/\">Org Mode</a></p>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-147457596-1\"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-147457596-1');
</script>
      </div>")

	(setq blog-head  "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>")

	(setq org-publish-project-alist
		  `(("page"
			 :base-directory ,blog-source-folder
			 :publishing-directory ,blog-target-folder
			 :publishing-function org-html-publish-to-html
			 :html-head  ,blog-head
			 :html-preamble ,blog-html-preamble
			 :html-postamble ,blog-html-postamble)
			("projects"
			 :base-directory ,(concat blog-source-folder "projects")
			 :publishing-directory ,(concat blog-target-folder "projects")
			 :base-extension "org"
			 :recursive t
			 :publishing-function org-html-publish-to-html
			 :html-head  ,blog-head
			 :html-preamble ,blog-html-preamble
			 :html-postamble ,blog-html-postamble)
			("articles"
			 :base-directory ,(concat blog-source-folder "articles")
			 :publishing-directory ,(concat blog-target-folder "articles")
			 :base-extension "org"
			 :recursive t
			 :publishing-function org-html-publish-to-html
			 :auto-sitemap t
			 :makeindex t
			 :sitemap-title "Blog Post"
			 :html-head  ,blog-head
			 :html-preamble ,blog-html-preamble
			 :html-postamble ,blog-html-postamble)
			("resources"
			 :base-directory ,blog-source-folder
			 :publishing-directory ,blog-target-folder
			 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
			 :recursive t
			 :publishing-function org-publish-attachment)
			("blog" :components ("page" "projects" "articles" "resources"))))))

(provide 'config-org)

