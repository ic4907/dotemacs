(package-initialize)

(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "http://melpa.org/packages/")))                     

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'load-path
			 "~/.emacs.d/config")

(require 'config-default)
(require 'config-gui)
(require 'config-org)
(require 'config-package)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
	(smartparens youdao-dictionary window-numbering web-mode use-package undo-tree smex rainbow-mode rainbow-delimiters popwin ox-reveal org-bullets nginx-mode magit js2-mode jazz-theme htmlize helm-themes helm-projectile graphviz-dot-mode exec-path-from-shell emmet-mode counsel company clj-refactor ag ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
