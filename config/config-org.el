(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

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
  (require 'org-tempo)
  (setq org-confirm-babel-evaluate nil)
  (setq org-log-done 'time)
  (setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))
  (setq org-refile-targets '(("~/Documents/inbox/inbox.org" :maxlevel . 3)))						   
  (setq org-agenda-files '("~/Documents/inbox/inbox.org"))
  (setq org-plantuml-jar-path
		(expand-file-name "~/Documents/tools/plantuml.jar"))
  (add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
  (org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))
  (setq org-startup-with-inline-images t)
  
  (setq org-capture-templates '(("t" "Todo [inbox]" entry
								 (file+headline "~/Documents/inbox/inbox.org" "Tasks")
								 "* TODO %i%?"))))

(use-package org-journal
  :ensure
  :bind (("C-c C-s" . org-journal-search))
  :config
  (setq org-journal-dir "~/Documents/journal/"))

(provide 'config-org)
