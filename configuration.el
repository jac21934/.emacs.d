(setq user-full-name "Jacob Carroll"
      user-mail-address "jac21934@gmail.com"
      )

(setq package-archives '(
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("marmalade" . "https://marmalade-repo.org/packages/") 
                         ("melpa" . "https://melpa.org/packages/") 
                         ("org" . "http://orgmode.org/elpa/") 
                         ) )

(unless package-archive-contents
  (package-refresh-contents))

(package-initialize)

(setq custom-file (make-temp-file "emacs-custom"))

(set-language-environment "UTF-8")

(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))
;;(add-to-list 'default-frame-alist '(height . 40))
;; (add-to-list 'default-frame-alist '(width . 100))

(setq inhibit-startup-message t)
(setq-default message-log-max nil)
(kill-buffer "*Messages*")

(fset 'yes-or-no-p 'y-or-n-p)

(tool-bar-mode -1)

(menu-bar-mode -1)

(display-time-mode 1)

(delete-selection-mode t)

(blink-cursor-mode 0)

(use-package powerline
  :ensure t
  )

(add-hook 'after-init-hook 'powerline-default-theme)
;; (powerline-default-theme)

(use-package ace-window
  :defer t
  :ensure t
  )

(global-set-key (kbd "C-x o") 'ace-window)

(setq linum-format "%d ")

(setq mouse-wheel-progressive-speed nil)

(setq scroll-conservatively 100)

(use-package scratch-message
  :ensure t
  )

;;  (setq initial-scratch-message 
;; [C-x C-f] Open [C-x C-s] Save [C-x s] Save as [C-x b] S/w buf [C-x k] Kill buf
;; ;; [C-x 1] Del others [C-x 0] Del current [C-x 2/3] Split-H/V [C-x o] S/w window
;; ;; [C-a/e] Begin/End of line [M-f/b] Next/Back word [C/M-v] Next/Back page
;; ;; [C/M-d] Del char/word [C-s/r] search/r-search [M-%] replace")

(use-package helm
  ;;:defer t
  :ensure t
  :init 
  (require 'helm-config)
  )

(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)

(defun helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))


(add-hook 'helm-minibuffer-set-up-hook
          'helm-hide-minibuffer-maybe)

(setq helm-autoresize-max-height 0)
(setq helm-autoresize-min-height 20)
(helm-autoresize-mode 1)

(helm-mode 1)

(setq helm-M-x-fuzzy-match t)

(global-set-key (kbd "M-x") 'helm-M-x)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(when (executable-find "ack-grep")
  (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
        helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))

(use-package helm-swoop
  :ensure t
  :defer t
  :bind  ( "C-s" . helm-swoop)
  )

(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(custom-theme-set-faces 'user
                        `(helm-grep-file ((t (:foreground "SpringGreen")))))

(use-package yasnippet
  :ensure t
  :defer t
  :init
  (yas-global-mode 1)
  )

(use-package ibuffer
   :defer t
   :ensure t
   :bind ("C-x C-b" . ibuffer)
;;   :init 
;;   (add-hook 'ibuffer-hook
;;             (lambda ()
;;               (ibuffer-vc-set-filter-groups-by-vc-root)
;;               (unless (eq ibuffer-sorting-mode 'alphabetic)
;;                 (ibuffer-do-sort-by-alphabetic))))
;;   (setq ibuffer-formats
;;         '((mark modified read-only vc-status-mini " "
;;                 (name 18 18 :left :elide)
;;                 " "
;;                 (size 9 -1 :right)
;;                 " "
;;                 (mode 16 16 :left :elide)
;;                 " "
;;                 (vc-status 16 16 :left)
;;                 " "
;;                filename-and-process)))
  )

(setq custom-safe-themes t)

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init 
  (add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-tomorrow-eighties)))
  )



(add-hook 'after-init-hook 'global-visual-line-mode)

(setq-default dired-listing-switches "-lhvA")

(setq dired-clean-up-buffers-too t)

(setq dired-recursive-copies 'always)

(setq dired-recursive-deletes 'top)

(use-package neotree
  :ensure t
  :defer t
  :bind ([f7] . neotree-toggle)
  )

(use-package pdf-tools
  :ensure t
  :defer t
  :init 
  (pdf-tools-install)
  :config
  (setq-default pdf-view-display-size 'fit-page)

  )

;;  (add-hook 'after-init-hook 'pdf-tools-install)

(add-hook 'prog-mode-hook 'linum-mode)

(add-hook 'prog-mode-hook 'hl-line-mode)

(setq-default tab-width 2)

(add-hook 'after-init-hook 'show-paren-mode)

(setq c-default-style "linux"
      c-basic-offset 4)

(use-package indent-guide
  :ensure t
  :defer t
  :init   (add-hook 'python-mode-hook 'indent-guide-mode)
  )

(use-package ess
  :ensure t
  :defer t
  :init   (add-hook 'ess-mode-hook 'linum-mode)
  )

(use-package js2-mode
  :ensure t
  :defer t
  :init (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  )

(add-hook 'latex-mode-hook 'linum-mode)

;;(add-to-list 'auto-mode-alist '("\\.tex\\'" . latex-mode-hook))

(add-hook 'LaTeX-mode-hook
          (lambda ()
            (LaTeX-math-mode)
            (setq TeX-master t)))

(add-hook 'org-mode-hook 'org-indent-mode)

(use-package org-bullets
  :ensure t
  :defer t
  :init  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )

(setq org-src-fontify-natively t)

(setq org-src-tab-acts-natively t)

(setq org-directory "~/org")

(defun org-file-path (filename)
  "Return the absolute address of an org file, given its relative name."
  (concat (file-name-as-directory org-directory) filename))

(setq org-inbox-file "~/Dropbox/inbox.org")
(setq org-index-file (org-file-path "index.org"))
(setq org-archive-location
      (concat (org-file-path "archive.org") "::* From %s"))

(use-package ox-twbs
  :ensure t
  :defer t
  )

(setq org-agenda-files (list org-index-file))

(defun hrs/mark-done-and-archive ()
  "Mark the state of an org-mode item as DONE and archive it."
  (interactive)
  (org-todo 'done)
  (org-archive-subtree))

(define-key org-mode-map (kbd "C-c C-x C-s") 'hrs/mark-done-and-archive)

(setq org-log-done 'time)

(custom-theme-set-faces 'user
                        `(org-table ((t (:foreground "LightCoral")))))

(custom-theme-set-faces 'user
                        `(org-link ((t (:foreground "IndianRed")))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (ruby . t)
   (dot . t)
   (gnuplot . t)
   (shell . t)
   (python . t)
   ))

(setq org-confirm-babel-evaluate nil)

(add-to-list 'org-structure-template-alist '("ss" "#+BEGIN_SRC emacs-lisp\n\n#+END_SRC"))

(use-package nov
  :ensure t
  :defer  t
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
  )

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(use-package origami
  :ensure t
  :defer t
  :init
  (add-hook 'c++-mode-hook 'origami-mode)
  (add-hook 'latex-mode-hook 'origami-mode)
  :bind (
         :map origami-mode-map
              ( "C-;" . origami-recursively-toggle-node)
              ( "C-:" . origami-toggle-all-nodes)
              )
  )



(use-package company
  :ensure t
  :defer t
  :init   (add-hook 'after-init-hook 'global-company-mode)
  )

(add-hook 'latex-mode-hook (lambda () (local-set-key "\C-x\C-a" 'tex-compile)))
;;  (add-hook 'c++-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
;; (add-hook 'fortran-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
;;(add-hook 'c-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
;; (add-hook 'emacs-lisp-mode-hook (lambda () (local-set-key "\C-x\C-a" 'eval-buffer)))

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
