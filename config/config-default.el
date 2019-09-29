(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)

(setq visible-bell 0)

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

(global-hl-line-mode +1)


(provide 'config-default)

