(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") )
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
;;(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package)
	)
;;(package-initialize)

;; Ensure org is installed
(use-package org
	:ensure org-plus-contrib)

;; Actually load init file
(org-babel-load-file (expand-file-name "~/.emacs.d/configuration.org"))
