(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(use-package simple
  :config
  (menu-bar-mode -1)
  (line-number-mode -1)
  (show-paren-mode 1)
  (auto-save-mode nil)
  (blink-cursor-mode 1)
  (delete-selection-mode t)
  (global-visual-line-mode t)
  (global-linum-mode t)
  (progn
	(setq auto-save-default nil)
	(setq visible-bell nil)
	(setq make-backup-files nil)
	(setq create-lockfiles nil)
	(setq debug-on-error nil)
	(setq-default tab-width 4)
	(setq x-select-enable-clipboard t
		  x-select-enable-primary t
		  save-interprogram-paste-before-kill t
		  apropos-do-all t
		  mouse-yank-at-point t)))

(use-package leuven-theme
  :ensure t
  :config
  (load-theme 'leuven t))

(set-frame-font "JetBrains Mono:pixelsize=14")

(dolist (charset '(han kana symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Hiragino Sans GB" :size 16.3)))

(custom-set-faces
 ;; '(org-document-title ((t (:height 1.0))))
 ;; '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
 ;; '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 ;; '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 ;; '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 ;; '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 
 '(rainbow-delimiters-depth-1-face ((t (:foreground "dark orange"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "deep pink"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "chartreuse"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "deep sky blue"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "yellow"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "orchid"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "spring green"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "sienna1")))))

(provide 'config-gui)
