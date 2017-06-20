
(setq user-full-name "Jacob Carroll"
      user-mail-address "jac21934@vt.edu"
      calendar-latitude 37.2
      calendar-longitude -80.4
      calendar-location-name "Blacksburg, VA")

(set-language-environment "UTF-8")

(add-to-list 'default-frame-alist '(height . 40))
(add-to-list 'default-frame-alist '(width . 100))

(setq inhibit-startup-message t)
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

(fset 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)

(setq mouse-wheel-progressive-speed nil)

(setq scroll-conservatively 100)

(setq initial-scratch-message 
";; [C-x C-f] Open [C-x C-s] Save [C-x s] Save as [C-x b] S/w buf [C-x k] Kill buf
;; [C-x 1] Del others [C-x 0] Del current [C-x 2/3] Split-H/V [C-x o] S/w window
;; [C-a/e] Begin/End of line [M-f/b] Next/Back word [C/M-v] Next/Back page
;; [C/M-d] Del char/word [C-s/r] search/r-search [M-%] replace")

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
("marmalade" . "https://marmalade-repo.org/packages/") 
("melpa" . "https://melpa.org/packages/") 
("org" . "http://orgmode.org/elpa/") ) )

(let ((default-directory (expand-file-name "~/.emacs.d/elpa/"))) 
 (setq load-path  
 (append 
 (let ((load-path (copy-sequence load-path)))
   (append (copy-sequence (normal-top-level-add-to-load-path '(".")))
   (normal-top-level-add-subdirs-to-load-path)))
         load-path)))

(require 'dired-x)
(require 'dired+)
(require 'dired-open)

(setq dired-open-extensions
      '(("mkv" . "vlc")
        ("mp4" . "vlc")
        ("avi" . "vlc")))

(setq-default dired-listing-switches "-lhvA")

(setq dired-clean-up-buffers-too t)

(setq dired-recursive-copies 'always)

(setq dired-recursive-deletes 'top)

(require 'neotree)
(global-set-key [f7] 'neotree-toggle)

(add-hook 'after-init-hook 'pdf-tools-install)

(delete-selection-mode t)

(add-hook 'prog-mode-hook 'linum-mode)

(setq-default tab-width 2)

(add-hook 'after-init-hook 'show-paren-mode)

(setq c-default-style "linux"
      c-basic-offset 4)

(add-hook 'latex-mode-hook 'linum-mode)

(require 'org)

(add-hook 'org-mode-hook 'org-indent-mode)

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq org-src-fontify-natively t)

;;(setq org-src-tab-acts-natively t)

(setq org-directory "~/org")

(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

(setq org-inbox-file "~/Dropbox/inbox.org")
(setq org-index-file (org-file-path "index.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

(setq org-agenda-files (list org-index-file))

(defun hrs/mark-done-and-archive ()
  "Mark the state of an org-mode item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree))

(define-key org-mode-map (kbd "C-c C-x C-s") 'hrs/mark-done-and-archive)

(setq org-log-done 'time)

(require 'ox-md)
(require 'ox-beamer)
(require 'ox-twbs)

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (dot . t)
   (gnuplot . t)))

(setq org-confirm-babel-evaluate nil)

(add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))

(setq org-export-with-smart-quotes t)

(setq TeX-parse-self t)

(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (setq TeX-master t)))

(setq org-html-postamble nil)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(add-to-list 'org-latex-packages-alist '("usenames,dvipsnames,svgnames" "xcolor"))
  ;;(setq org-latex-listings 'minted)

(setq org-latex-minted-options
           '(("frame" "lines")
             ("fontsize" "\\scriptsize")
             ("bgcolor" "LightGray")))

(setq org-src-fontify-natively t)

(custom-theme-set-faces 'user
`(org-table ((t (:foreground "LightCoral")))))

(custom-theme-set-faces 'user
 `(org-link ((t (:foreground "IndianRed")))))

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(add-hook 'c++-mode-hook 'origami-mode)
(add-hook 'latex-mode-hook 'origami-mode)
(add-hook 'origami-mode-hook (lambda () (local-set-key (kbd "C-;") 'origami-recursively-toggle-node)))
(add-hook 'origami-mode-hook (lambda () (local-set-key (kbd "C-:") 'origami-toggle-all-nodes)))

(add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-tomorrow-eighties)))

(add-hook 'after-init-hook 'global-visual-line-mode)

(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'latex-mode-hook (lambda () (local-set-key "\C-x\C-a" 'tex-compile)))
(add-hook 'c++-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
(add-hook 'fortran-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
(add-hook 'c-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
(add-hook 'emacs-lisp-mode-hook (lambda () (local-set-key "\C-x\C-a" 'eval-buffer)))

(add-hook 'graphviz-dot-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))

(add-hook 'c++-mode-hook
   (lambda ()
            (set (make-local-variable 'compile-command)
                                         (let ((file (file-name-nondirectory buffer-file-name)))
                                         (format "%s -o %s %s"
                                                                         (or (getenv "CC") "g++")
                                                                         (file-name-sans-extension file)
                                                                         file)))))

(add-hook 'fortran-mode-hook
                                        (lambda ()
                                                (set (make-local-variable 'compile-command)
                                                (let ((file (file-name-nondirectory buffer-file-name)))
                                                                 (format "%s -o %s %s"
                                                                                         (or (getenv "CC") "gfortran -ffree-form")
                                                                                         (file-name-sans-extension file)
                                                                                         file)))))

(defun kill-compile-frame-if-successful (buffer string) 
  " kill a compilation buffer if succeeded without warnings " 
  (if (and 
       (or (string-match "compilation" (buffer-name buffer)) 
                                         (string-match "tex-shell" (buffer-name buffer))
                                         )
       (or (string-match "finished" string) 
                                         (string-match "Transcript written")
                                         )
       (not 
        (with-current-buffer buffer 
          (search-forward "warning" nil t)))) 
      (run-with-timer 1 nil 
                      'delete-other-windows 
                                                                                        )))
(add-hook 'compilation-finish-functions 'kill-compile-frame-if-successful)

(define-minor-mode sensitive-mode
        "For sensitive files like password lists.
It disables backup creation and auto saving.

With no argument, this command toggles the mode.
Non-null prefix argument turns on the mode.
Null prefix argument turns off the mode."
  ;; The initial value.
  nil
  ;; The indicator for the mode line.
  " Sensitive"
  ;; The minor mode bindings.
  nil
  (if (symbol-value sensitive-mode)
                (progn
        ;; disable backups
        (set (make-local-variable 'backup-inhibited) t) 
        ;; disable auto-save
        (if auto-save-default
                (auto-save-mode -1)))
                                                                                                                                                                ;resort to default value of backup-inhibited
    (kill-local-variable 'backup-inhibited)
                                                                                                                                                                ;resort to default auto save setting
    (if auto-save-default
                (auto-save-mode 1))))
