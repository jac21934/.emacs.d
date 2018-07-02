(package-initialize)

(require 'org)
(org-babel-load-file "~/.emacs.d/configuration.org")


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
	 (quote
		("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(graphviz-dot-indent-width "2")
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(org-agenda-files (quote ("~/org/index.org")))
 '(package-selected-packages
	 (quote
		(use-package helm org org-babel-eval-in-repl discover-my-major indent-guide linum-relative powerline symon js2-mode ace-window gnuplot-mode gnuplot hl-spotlight smart-mode-line nov magit evil lua-mode org-bullets zenburn-theme yafolding undo-tree sublimity stripe-buffer pdf-tools ox-twbs ox-rst ox-epub origami neotree multi-term minimap kaolin-theme htmlize hc-zenburn-theme graphviz-dot-mode ggtags folding fireplace ess dired-open dired+ cyberpunk-theme company color-theme-sanityinc-tomorrow color-theme-monokai beacon ample-zen-theme ample-theme aggressive-indent))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-link ((t (:foreground "IndianRed"))))
 '(org-table ((t (:foreground "LightCoral")))))
