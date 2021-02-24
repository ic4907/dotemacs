(require 'org-tempo)

(setenv "BLOG_HOME" (concat (getenv "HOME") "/Documents/blog/"))

(setq export-config-file (concat (getenv "BLOG_HOME") "export.el"))

(if (not (file-exists-p export-config-file))
	(copy-file "~/.emacs.d/config/export.el" export-config-file))

(load-file export-config-file)

(use-package org-bullets
  :ensure t
  :config
  (progn
	(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))))

(provide 'config-org)

