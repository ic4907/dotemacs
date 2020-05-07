(setenv "BLOG_HOME" (concat (getenv "HOME") "/Documents/blog/"))

(setq export-config-file (concat (getenv "BLOG_HOME") "export.el"))

(if (not (file-exists-p export-config-file))
	(copy-file "~/.emacs.d/config/export.el" export-config-file))

(load-file export-config-file)

(provide 'config-org)

