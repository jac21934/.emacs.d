;;; julia-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (inferior-julia julia-mode) "julia-mode" "julia-mode.el"
;;;;;;  (22749 16711 951783 47000))
;;; Generated autoloads from julia-mode.el

(add-to-list 'auto-mode-alist '("\\.jl\\'" . julia-mode))

(autoload 'julia-mode "julia-mode" "\
Major mode for editing julia code.

\(fn)" t nil)

(autoload 'inferior-julia "julia-mode" "\
Run an inferior instance of `julia' inside Emacs.

\(fn)" t nil)

(defalias 'run-julia #'inferior-julia "\
Run an inferior instance of `julia' inside Emacs.")

;;;***

;;;### (autoloads nil nil ("julia-mode-pkg.el") (22749 16712 27557
;;;;;;  703000))

;;;***

(provide 'julia-mode-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; julia-mode-autoloads.el ends here
