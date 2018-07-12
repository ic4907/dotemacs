(blink-cursor-mode 1)

(use-package helm-themes :ensure t)

(use-package jazz-theme :ensure t)
(load-theme 'jazz t)

(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(setq debug-on-error nil)

(show-paren-mode 1)

(setq-default tab-width 4)

(setq x-select-enable-clipboard t
      x-select-enable-primary t
      save-interprogram-paste-before-kill t
      apropos-do-all t
      mouse-yank-at-point t)

(set-frame-font "Monaco:pixelsize=12")
(dolist (charset '(han kana symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Hiragino Sans GB" :size 14.4)))

(delete-selection-mode t)
(global-visual-line-mode 1)

;; fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(global-set-key (kbd "<s-return>") 'toggle-fullscreen)

(provide 'init-ui)
