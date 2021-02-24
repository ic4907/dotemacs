(setenv "ROAM_HOME" (concat (getenv "HOME") "/Documents/blog/articles"))

(use-package org-roam
  :ensure t
  :hook
  (after-init . org-roam-mode)
  :custom
  (org-roam-directory (getenv "ROAM_HOME"))
  :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph)
			   ("C-c n c" . org-roam-capture))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))

;; (use-package org-roam-server
;;   :ensure t
;;   :config
;;   (setq org-roam-server-host "127.0.0.1"
;;         org-roam-server-port 8010
;;         org-roam-server-authenticate nil
;;         org-roam-server-export-inline-images t
;;         org-roam-server-serve-files nil
;;         org-roam-server-served-file-extensions '("pdf" "mp4" "ogv")
;;         org-roam-server-network-poll t
;;         org-roam-server-network-arrows nil
;;         org-roam-server-network-label-truncate t
;;         org-roam-server-network-label-truncate-length 60
;;         org-roam-server-network-label-wrap-length 20))

(require 'org-roam-protocol)
;; (org-roam-server-mode)

(setq org-roam-capture-ref-templates
      '(("r" "ref" plain (function org-roam-capture--get-point)
         ""
         :file-name "${slug}"
         :head "#+title: ${title}\n#+roam_key: ${ref}\n"
         :unnarrowed t)))

(server-mode)
(require 'org-protocol)

(provide 'config-roam)
