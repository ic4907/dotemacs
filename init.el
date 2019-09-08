(package-initialize)

(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://stable.melpa.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'load-path
			 "~/.emacs.d/config")

(require 'config-default)
(require 'config-gui)
(require 'config-org)
(require 'config-package)

(setq custom-file
	  (concat user-emacs-directory "/custom.el"))
