(require 'use-package)

;; recentf
(recentf-mode 1)
(setq recentf-max-saved-items 512)

;; projectile
(use-package projectile
  :ensure t
  :commands (projectile-find-file projectile-switch-project)
  :diminish projectile-mode
  :init
  (use-package helm-projectile
    :ensure t
    :bind (("s-p" . helm-projectile-find-file)
           ("s-P" . helm-projectile-switch-project)))
  :config
  (progn
    (setq projectile-completion-system 'helm
          projectile-switch-project-action 'projectile-dired
          projectile-remember-window-configs t
          projectile-use-git-grep 1)))

(use-package ag :ensure t)

(use-package window-numbering
  :ensure t
  :config
  (progn
	(window-numbering-mode t)))

;; shell
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(use-package exec-path-from-shell :ensure t)

(use-package clj-refactor
  :diminish clj-refactor-mode
  :config (cljr-add-keybindings-with-prefix "C-c j"))

(use-package rainbow-delimiters :ensure t)

(defun my-clojure-mode-hook ()
  (rainbow-delimiters-mode)
  (electric-pair-mode)
  (projectile-mode)
  (clj-refactor-mode 1)
  (yas-minor-mode 1) ; for adding require/use/import statements
  ;; This choice of keybinding leaves cider-macroexpand-1 unbound
  (cljr-add-keybindings-with-prefix "C-c C-m"))

(use-package clojure-mode
  :ensure t
  :config (progn
			(add-hook 'clojure-mode-hook 'my-clojure-mode-hook)
			(setq clojure-defun-style-default-indent t)))

(use-package cider
  :init
  (add-hook 'cider-mode-hook #'clj-refactor-mode))

(use-package expand-region
  :defer t
  :bind (("C-c e" . er/expand-region)
         ("C-M-@" . er/contract-region)))

;; magit
(use-package magit
  :ensure t
  :config
  (progn
    (setq magit-push-always-verify nil)
    (setq magit-revert-buffers t)))

;; web mode
(use-package web-mode
  :ensure t
  :config (progn
            (add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
            (add-to-list 'auto-mode-alist '("\\.vue\\'" . web-mode))
            (setq-default web-mode-comment-formats (remove '("javascript" . "/*") web-mode-comment-formats))
            (add-to-list 'web-mode-comment-formats '("javascript" . "//"))))

;; js2 mode
(use-package js2-mode
  :ensure t
  :config (progn
            (setq js2-strict-missing-semi-warning nil)
            (setq js2-strict-trailing-comma-warning nil)
            (setq js2-mode-assume-strict t)
            (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))))

(use-package css-mode
  :defer t
  :init
  (add-hook 'css-mode-hook 'skewer-css-mode))

(use-package json-mode :defer t)

(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  (setq
   company-echo-delay 0
   company-idle-delay 0.2
   company-minimum-prefix-length 1
   company-tooltip-align-annotations t
   company-tooltip-limit 20))

(use-package popwin :ensure t)
(popwin-mode 1)

(use-package emmet-mode :ensure t)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

(use-package nginx-mode :ensure t)

(use-package youdao-dictionary
  :ensure t
  :init
  (setq url-automatic-caching t)
  :config
  (global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+))

(use-package window-numbering
  :ensure t)

(use-package counsel
  :ensure t)

(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq enable-recursive-minibuffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
	(global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-find-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    (advice-add 'swiper :after #'recenter)))

(use-package smex
  :ensure t
  :config
  (global-set-key (kbd "M-x") 'smex))

(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns))
    (exec-path-from-shell-initialize)))

(use-package undo-tree
  :ensure t
  :diminish undo-tree-mode
  :init
  (global-undo-tree-mode 1)
  :config
  (defalias 'redo 'undo-tree-redo)
  :bind (("C-z" . undo)     ; Zap to character isn't helpful
         ("C-S-z" . redo)))

(use-package ace-window
  :ensure t
  :init
    (setq aw-keys '(?a ?s ?d ?f ?j ?k ?l ?o))
    (global-set-key (kbd "C-x o") 'ace-window)
  :diminish ace-window-mode)


(provide 'init-package)
