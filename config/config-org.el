(require 'org-tempo)

(setenv "BLOG_HOME" (concat (getenv "HOME") "/Documents/blog/"))

(setq export-config-file (concat (getenv "BLOG_HOME") "export.el"))

(if (not (file-exists-p export-config-file))
	(copy-file "~/.emacs.d/config/export.el" export-config-file))

(load-file export-config-file)

;; (use-package org-bullets
;;   :ensure t
;;   :hook (org-mode . org-bullets-mode))

(use-package org-bullets
  :custom
  (org-bullets-bullet-list '("◉" "☯" "○" "☯" "✸" "☯" "✿" "☯" "✜" "☯" "◆" "☯" "▶"))
  (org-ellipsis "⤵")
  :hook (org-mode . org-bullets-mode))

(server-mode)

(use-package org
  :demand
  :config
  (global-set-key (kbd "C-c C-w") 'org-refile)
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-refile-targets '(("~/Documents/inbox/gtd.org" :maxlevel . 3)
							 ("~/Documents/inbox/someday.org" :level . 1)
							 ("~/Documents/inbox/tickler.org" :maxlevel . 2)))
  (setq org-agenda-files '("~/Documents/inbox/inbox.org"
						   "~/Documents/inbox/gtd.org"
						   "~/Documents/inbox/tickler.org"))
  (setq org-plantuml-jar-path
		(expand-file-name "~/Documents/tools/plantuml.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  (setq org-startup-with-inline-images t)
  
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
								 (file+headline "~/Documents/inbox/inbox.org" "Tasks")
								 "* TODO %i%?")
								("T" "Tickler" entry
								 (file+headline "~/Documents/inbox/tickler.org" "Tickler")
								 "* %i%? \n %U"))))

(use-package org-journal
  :ensure
  :bind (("C-c C-s" . org-journal-search)))

(provide 'config-org)
