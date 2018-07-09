;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(setq my/package-list
      '(cider
	clj-refactor
	clojure-mode
	company
	exec-path-from-shell
	flycheck
	git
	git-gutter
	git-gutter-fringe
	js2-mode
	json-mode
	json-reformat
	magit
	paredit
	popup
	projectile
	rainbow-delimiters
	rainbow-mode
	smartparens
	web-mode
	yasnippet
	use-package
	))

;; fetch the list of packages available
(unless (file-exists-p package-user-dir)
  (package-refresh-contents))

(defalias 'yes-or-no-p 'y-or-n-p)

;; install the missing packages
(dolist (p my/package-list)
  (when (not (package-installed-p p)) (package-install p)))

(add-to-list 'load-path "~/.emacs.d/config")
(require 'ui-conf)
(require 'package-conf)
