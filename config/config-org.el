(require 'org)
(require 'ox-html)
(require 'ox-publish)
;;(require 'ox-rss)

(use-package htmlize
  :ensure t)

(setq my-site-project-path (concat (getenv "HOME") "/Documents/notes/"))
(setq my-site-publish-path (concat (getenv "HOME") "/Public/notes/"))

(defun my-blog-get-preview (file)
  "The comments in FILE have to be on their own lines, prefereably before and after paragraphs."
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (let ((beg (+ 1 (re-search-forward "^#\\+BEGIN_PREVIEW$")))
          (end (progn (re-search-forward "^#\\+END_PREVIEW$")
                      (match-beginning 0))))
      (buffer-substring beg end))))

(defun my-blog-sitemap (project &optional sitemap-filename)
  "Generate the sitemap for my blog."
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         file sitemap-buffer)
    (with-current-buffer
        (let ((org-inhibit-startup t))
          (setq sitemap-buffer
                (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      ;; loop through all of the files in the project
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link ;; changed this to fix links. see postprocessor.
               (file-relative-name file (file-name-as-directory
                                         (expand-file-name (concat (file-name-as-directory dir) "..")))))
              (oldlocal localdir))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          ;; sitemap shouldn't list itself
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (let (;; get the title and date of the current file
                  (title (org-publish-format-file-entry "%t" file project-plist))
                  (date (org-publish-format-file-entry "%d" file project-plist))
                  ;; get the preview section from the current file
                  (preview (my-blog-get-preview file))
                  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
              ;; insert a horizontal line before every post, kill the first one
              ;; before saving
              (insert "-----\n")
              (cond ((string-match-p regexp title)
                     (string-match regexp title)
                     ;; insert every post as headline
                     (insert (concat"* " (match-string 1 title)
                                    "[[file:" link "]["
                                    (match-string 2 title)
                                    "]]" (match-string 3 title) "\n")))
                    (t (insert (concat "* [[file:" link "][" title "]]\n"))))
              ;; insert the date, preview, & read more link
              (insert (concat date "\n\n"))
              (insert preview)
              (insert (concat "[[file:" link "][Read More...]]\n"))))))
      ;; kill the first hrule to make this look OK
      (goto-char (point-min))
      (let ((kill-whole-line t)) (kill-line))
      (save-buffer))
    (or visiting (kill-buffer sitemap-buffer))))

(my-blog-sitemap)

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

	(setq orgweb-html-preamble "
<h1 class=\"title\"><a href=\"/\">将大培的博客 </a>
  <p class=\"subtitle\">何逊而今渐老，都忘却春风词笔。</p>
</h1>
<nav>
  <a href=\"/\">About</a>
  <a href=\"/cv\">CV</a>
  <a href=\"/sitemap.html\">Blog</a>
</nav>")

	(setq orgweb-html-postamble "<div>
<p>Copyright 2019 by Jiang Dapei.
Proudly published with <a href=\"https://www.gnu.org/software/emacs/\">Emacs</a> and <a href=\"https://orgmode.org/\">Org Mode</a>
</div>")
	
	(setq org-publish-project-alist
		  `(("home"
			 :base-directory ,my-site-project-path
			 :publishing-directory ,my-site-publish-path
			 :publishing-function org-html-publish-to-html
			 :html-doctype "html5"
			 :html-html5-fancy t
			 :html-head  "<link rel=\"stylesheet\" href=\"/css/ic4907.css\" type=\"text/css\"/>"
			 :html-preamble ,orgweb-html-preamble
			 :html-postamble ,orgweb-html-postamble)
			("articles"
			 :base-directory ,(concat my-site-project-path "articles")
			 :base-extension "org"
			 :publishing-directory ,(concat my-site-publish-path "articles")
			 :publishing-function org-html-publish-to-html
			 :with-author t
			 :with-email t
			 :with-creator t
			 :recursive t
			 :email "shalir@outlook.com"
			 :auto-sitemap t
			 :sitemap-filename "sitemap.org"

			 :sitemap-function my-blog-sitemap
			 :sitemap-sort-files anti-chronologically
			 :sitemap-date-format "Published: %a %b %d %Y"
			 
			 :makeindex t
			 :html-doctype "html5"
			 :exclude "\\(thoughtworks\\|gtd\\)/.*"
			 :html-html5-fancy t
			 :html-head  "<link rel=\"stylesheet\" href=\"/css/ic4907.css\" type=\"text/css\"/>"
			 :html-preamble ,orgweb-html-preamble
			 :html-postamble ,orgweb-html-postamble
			 :html-head-include-default-style nil)
			("static"
			 :base-directory ,my-site-project-path
			 :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
			 :publishing-directory ,my-site-publish-path
			 :exclude "\\(thoughtworks\\|gtd\\)/.*"
			 :recursive t
			 :publishing-function org-publish-attachment)

			("notebook" :components ("home" "articles" "static"))))))

(provide 'config-org)
