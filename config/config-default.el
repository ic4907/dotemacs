(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)

(setq visible-bell 1)
(setq-default tab-always-indent 'complete)

;; fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(global-set-key (kbd "<s-return>") 'toggle-fullscreen)

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(provide 'config-default)

