(require 'org)

(setq org-html-htmlize-output-type `nil)

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

(setq inkresi/blog-title "蒋大培的博客"
	  inkresi/blog-subtitle "爱技术，喜欢计算机编程。"
	  inkresi/source-folder (or (getenv "BLOG_HOME") default-directory)
	  inkresi/target-folder (concat inkresi/source-folder "dist/")
	  inkresi/preamble-template (concat inkresi/source-folder "_templates/preamble.html")
	  inkresi/postamble-template (concat inkresi/source-folder "_templates/postamble.html")
	  inkresi/blog-head  "<link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\"/>")


;; generate blog header with templat file
(defun inkresi/preamble (&optional title subtitle preamble)
  (let ((f (lambda (str) (save-match-data
						   (replace-regexp-in-string
							"\n?</?p>\n?" ""
							(org-trim (or (org-export-string-as str 'html t) "")) t t)))))
	(with-temp-buffer (insert-file inkresi/preamble-template)
					  (search-forward "%TITLE" nil t)
					  (replace-match (funcall f (format "@@html:<a href=\"/\">@@%s @@html:</a>@@" inkresi/blog-title)))
					  (search-forward "%SUBTITLE" nil t)
					  (replace-match (funcall f inkresi/blog-subtitle))
					  (buffer-string))))


;; generate blog footer with templat file
(defun inkresi/postamble (&optional title subtitle postamble)
  (with-temp-buffer (insert-file inkresi/postamble-template)
					(buffer-string)))

(defun inkresi/sitemap (title list)
  (setq site-title (concat "#+TITLE: " title))
  (mapconcat
   'identity
   (list site-title
	 (org-list-to-subtree list nil '(:istart "** "))
	 "\n\n")))
  ;; (let ((site-title (concat "#+TITLE: " title)))
  ;; 	(mapconcat
  ;; 	 'identity
  ;; 	 '(site-title
  ;;      (org-list-to-subtree list nil '(:istart "** "))
  ;;      "#+OPTIONS: title:nil num:nil")
;; 	 "\n\n")))

(setq org-publish-project-alist
	  `(("page"
		 :base-directory ,inkresi/source-folder
		 :publishing-directory ,inkresi/target-folder
		 :publishing-function org-html-publish-to-html
		 :html-head  ,inkresi/blog-head
		 :html-preamble ,(inkresi/preamble nil "")
		 :html-postamble ,(inkresi/postamble nil ""))
		("projects"
		 :base-directory ,(concat inkresi/source-folder "projects")
		 :publishing-directory ,(concat inkresi/target-folder "projects")
		 :base-extension "org"
		 :recursive t
		 :publishing-function org-html-publish-to-html
		 :html-head  ,inkresi/blog-head
		 :html-preamble ,(inkresi/preamble nil "")
		 :html-postamble ,(inkresi/postamble nil ""))
		("articles"
		 :base-directory ,(concat inkresi/source-folder "articles")
		 :publishing-directory ,(concat inkresi/target-folder "articles")
		 :base-extension "org"
		 :recursive t
		 :exclude "level-.*\\|.*\.draft\.org"
		 :publishing-function org-html-publish-to-html
		 :auto-sitemap t
		 :sitemap-function inkresi/sitemap
		 :sitemap-title ,(format "Blog posts - %s" inkresi/blog-title)
		 :html-head  ,inkresi/blog-head
		 :html-preamble ,(inkresi/preamble nil "")
		 :html-postamble ,(inkresi/postamble nil ""))
		("resources"
		 :base-directory ,inkresi/source-folder
		 :publishing-directory ,inkresi/target-folder
		 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
		 :recursive t
		 :publishing-function org-publish-attachment)
		("blog" :components ("page" "projects" "articles" "resources"))))
