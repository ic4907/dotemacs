(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)

(setq default-directory "~/")
(setq command-line-default-directory "~/")

(setq visible-bell 1)

(setq tab-always-indent nil)
(setq indent-tabs-mode t)   ;; for tab-based indentation
(setq indent-tabs-mode nil) ;; for space-based indentation

;; fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(global-set-key (kbd "<s-return>") 'toggle-fullscreen)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(display-time)

(provide 'config-default)

