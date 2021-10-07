(use-package easy-hugo
  :ensure t
  :init
  (setq easy-hugo-basedir "~/Documents/hugo/blog//")
  (setq easy-hugo-url "https://inkresi.tech")
  (setq easy-hugo-sshdomain "inkresi")
  (setq easy-hugo-root "~/Documents/hugo/")
  (setq easy-hugo-default-ext ".org")
  (setq easy-hugo-org-header t)
  (setq easy-hugo-previewtime "300")
  :bind ("C-c C-e" . easy-hugo))


(provide 'config-hugo)
