(require 'org-tempo)

(setenv "BLOG_HOME" (concat (getenv "HOME") "/Documents/blog/"))

(setq export-config-file (concat (getenv "BLOG_HOME") "export.el"))

(setq gtd-path (concat (getenv "HOME") "/Documents/inbox/"))

(if (not (file-exists-p export-config-file))
	(copy-file "~/.emacs.d/config/export.el" export-config-file))

(load-file export-config-file)

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(server-mode)

(use-package org
  :demand
  :config
  (global-set-key (kbd "C-c C-w") 'org-refile)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-refile-targets '(((concat gtd-path "gtd.org") :maxlevel . 3)
							 ((concat gtd-path "someday.org") :level . 1)
							 ((concat gtd-path "tickler.org") :maxlevel . 2)))
  (setq org-agenda-files '((concat gtd-path "inbox.org")
						   (concat gtd-path "gtd.org")
						   (concat gtd-path "tickler.org")))
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
								 (file+headline (concat gtd-path "inbox.org") "Tasks")
								 "* TODO %i%?")
								("T" "Tickler" entry
								 (file+headline (concat gtd-path "tickler.org") "Tickler")
								 "* %i%? \n %U"))))

(setq org-plantuml-jar-path (expand-file-name "~/Documents/tools/plantuml.jar"))
(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(provide 'config-org)
