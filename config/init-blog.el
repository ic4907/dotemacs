(require 'ox-html)
(require 'ox-publish)

(use-package htmlize
  :ensure t)

(setq org-mode-websrc-directory (concat (getenv "HOME") "/Documents/blog/"))
(setq org-mode-notesrc-directory (concat (getenv "HOME") "/Documents/blog/notes/"))
(setq org-mode-publishing-directory (concat (getenv "HOME") "/Public/blog"))

(setq org-publish-project-alist
      `(("all"
         :components ("blog-content" "blog-static" "org-notes"))

        ("blog-content"
         :base-directory       ,org-mode-websrc-directory
         :base-extension       "org"
         :publishing-directory ,org-mode-publishing-directory
         :recursive            t
         :publishing-function  org-html-publish-to-html
         :preparation-function org-mode-blog-prepare
         :export-with-tags     nil
         :headline-levels      4
         :auto-preamble        t
         :auto-postamble       nil
         :auto-sitemap         t
		 :makeindex            t
         :sitemap-title        "Dapei Jiang's Blog"
         :section-numbers      nil
         :table-of-contents    nil
         :with-toc             nil
         :with-author          nil
         :with-creator         nil
         :with-tags            nil
         :with-smart-quotes    t

         :html-doctype         "html5"
         :html-html5-fancy     t
         :html-preamble        org-mode-blog-preamble
         :html-postamble       org-mode-blog-postamble
         ;; :html-postamble "<hr><div id='comments'></div>"
         :html-head  "<link rel=\"stylesheet\" href=\"/css/styles.css\" type=\"text/css\"/>\n
            <link rel=\"stylesheet\" href=\"/css/pure-min.css\" type=\"text/css\"/>"
         :html-head-extra "<link rel=\"shortcut icon\" href=\"/img/dragon-head.png\">
            <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\" />"
         :html-head-include-default-style nil
         )

        ("blog-static"
         :base-directory       ,org-mode-websrc-directory
         :base-extension       "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|svg"
         :publishing-directory ,org-mode-publishing-directory
         :recursive            t
         :publishing-function  org-publish-attachment
         )))

(defun org-mode-blog-preamble (options)
  "The function that creates the preamble top section for the blog.
OPTIONS contains the property list from the org-mode export."
  (let ((base-directory (plist-get options :base-directory)))
    (org-babel-with-temp-filebuffer (expand-file-name "header.html" base-directory) (buffer-string))))

(defun org-mode-blog-postamble (options)
  "The function that creates the postamble, or bottom section for the blog.
OPTIONS contains the property list from the org-mode export."
  (let ((base-directory (plist-get options :base-directory)))
    (org-babel-with-temp-filebuffer (expand-file-name "footer.html" base-directory) (buffer-string))))

(defun org-mode-blog-prepare ()
  "`index.org' should always be exported so touch the file before publishing."
  (let* ((base-directory (plist-get project-plist :base-directory))
         (buffer (find-file-noselect (expand-file-name "index.org" base-directory) t)))
    (with-current-buffer buffer
      (set-buffer-modified-p t)
      (save-buffer 0))
    (kill-buffer buffer)))

(provide 'init-blog)
