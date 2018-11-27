(defalias 'yes-or-no-p 'y-or-n-p)
(global-auto-revert-mode 1)

;; fullscreen
(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
   nil 'fullscreen
   (when (not (frame-parameter nil 'fullscreen)) 'fullboth)))

(global-set-key (kbd "<s-return>") 'toggle-fullscreen)

(provide 'config-default)
