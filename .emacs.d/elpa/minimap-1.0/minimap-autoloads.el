;;; minimap-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "minimap" "minimap.el" (0 0 0 0))
;;; Generated autoloads from minimap.el

(autoload 'minimap-create "minimap" "\
Create a minimap sidebar for the current window.

\(fn)" t nil)

(autoload 'minimap-kill "minimap" "\
Kill minimap for current buffer.
Cancel the idle timer if no more minimaps are active.

\(fn)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "minimap" '("minimap-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; minimap-autoloads.el ends here
