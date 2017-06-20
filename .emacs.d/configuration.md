<div id="table-of-contents">
<h2>Table of Contents</h2>
<div id="text-table-of-contents">
<ul>
<li><a href="#sec-1">Set Personal Information</a></li>
<li><a href="#sec-2">Environment Settings</a>
<ul>
<li><a href="#sec-2-1">Scrolling settings</a></li>
<li><a href="#sec-2-2">Scratch Message</a></li>
</ul>
</li>
<li><a href="#sec-3">Repositories and File Loading</a>
<ul>
<li><a href="#sec-3-1">Repositories</a></li>
<li><a href="#sec-3-2">Loading Files</a></li>
</ul>
</li>
<li><a href="#sec-4">Directory Manager Settings</a>
<ul>
<li><a href="#sec-4-1">Dired</a></li>
<li><a href="#sec-4-2">NeoTree</a></li>
</ul>
</li>
<li><a href="#sec-5">PDF-Tools</a></li>
<li><a href="#sec-6">Programming Settings</a>
<ul>
<li><a href="#sec-6-1">General Settings</a></li>
<li><a href="#sec-6-2">C/C++ Settings</a></li>
</ul>
</li>
<li><a href="#sec-7">LaTeX</a></li>
<li><a href="#sec-8">Org-Mode</a>
<ul>
<li><a href="#sec-8-1">Initialization and Hooks</a></li>
<li><a href="#sec-8-2">Task Management</a></li>
<li><a href="#sec-8-3">Exporting</a>
<ul>
<li><a href="#sec-8-3-1">TeX configuration</a></li>
<li><a href="#sec-8-3-2">Exporting to HTML</a></li>
<li><a href="#sec-8-3-3">Exporting to PDF</a></li>
</ul>
</li>
<li><a href="#sec-8-4">Visuals</a></li>
</ul>
</li>
<li><a href="#sec-9">Backups</a></li>
<li><a href="#sec-10">Origami Mode</a></li>
<li><a href="#sec-11">Visuals and Themes</a>
<ul>
<li><a href="#sec-11-1">Current Theme</a></li>
<li><a href="#sec-11-2">Visual Line Mode</a></li>
</ul>
</li>
<li><a href="#sec-12">Predictive Text</a>
<ul>
<li><a href="#sec-12-1">Company Mode</a></li>
</ul>
</li>
<li><a href="#sec-13">Compilation Shortcuts</a>
<ul>
<li><a href="#sec-13-1">Shortcuts</a></li>
<li><a href="#sec-13-2">Definition of the compile function</a>
<ul>
<li><a href="#sec-13-2-1"><code>C++-mode</code> definition.</a></li>
<li><a href="#sec-13-2-2"><code>Fortran-mode</code> definition.</a></li>
</ul>
</li>
<li><a href="#sec-13-3">Kill  Compilation Window</a></li>
</ul>
</li>
<li><a href="#sec-14">Sensitivity Mode</a></li>
</ul>
</div>
</div>


# Set Personal Information<a id="sec-1" name="sec-1"></a>

Setting some personal information for ease of compilation into LaTeX later on.

    (setq user-full-name "Jacob Carroll"
          user-mail-address "jac21934@vt.edu"
          calendar-latitude 37.2
          calendar-longitude -80.4
          calendar-location-name "Blacksburg, VA")

# Environment Settings<a id="sec-2" name="sec-2"></a>

Tell emacs to use Unicode-8.

    (set-language-environment "UTF-8")

Set startup window size.

    (add-to-list 'default-frame-alist '(height . 40))
    (add-to-list 'default-frame-alist '(width . 100))

I don&rsquo;t like the startup splash, or the messages buffer.

    (setq inhibit-startup-message t)
    (setq-default message-log-max nil)
    (kill-buffer "*Messages*")

Get&rsquo;s rid of yes or no questions, replaces them with y or n.

    (fset 'yes-or-no-p 'y-or-n-p)

Remove the tool bar.

    (tool-bar-mode -1)

## Scrolling settings<a id="sec-2-1" name="sec-2-1"></a>

Set scrolling speed to not accelerate.

    (setq mouse-wheel-progressive-speed nil)

When point goes outside the window, Emacs usually recenters the buffer point. I’m not crazy about that. This changes scrolling behavior to only scroll as far as point goes.

    (setq scroll-conservatively 100)

## Scratch Message<a id="sec-2-2" name="sec-2-2"></a>

Sets the scratch message to be a helpful reminder for key bindings

    (setq initial-scratch-message 
    ";; [C-x C-f] Open [C-x C-s] Save [C-x s] Save as [C-x b] S/w buf [C-x k] Kill buf
    ;; [C-x 1] Del others [C-x 0] Del current [C-x 2/3] Split-H/V [C-x o] S/w window
    ;; [C-a/e] Begin/End of line [M-f/b] Next/Back word [C/M-v] Next/Back page
    ;; [C/M-d] Del char/word [C-s/r] search/r-search [M-%] replace")

# Repositories and File Loading<a id="sec-3" name="sec-3"></a>

## Repositories<a id="sec-3-1" name="sec-3-1"></a>

Setting up the package archives

    (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
    ("marmalade" . "https://marmalade-repo.org/packages/") 
    ("melpa" . "https://melpa.org/packages/") 
    ("org" . "http://orgmode.org/elpa/") ) )

## Loading Files<a id="sec-3-2" name="sec-3-2"></a>

This recursively loads all paths in *elpa*. It was necessary for some reason.

    (let ((default-directory (expand-file-name "~/.emacs.d/elpa/"))) 
     (setq load-path  
     (append 
     (let ((load-path (copy-sequence load-path)))
       (append (copy-sequence (normal-top-level-add-to-load-path '(".")))
       (normal-top-level-add-subdirs-to-load-path)))
             load-path)))

# Directory Manager Settings<a id="sec-4" name="sec-4"></a>

## Dired<a id="sec-4-1" name="sec-4-1"></a>

Load up the assorted `dired` extensions.

    (require 'dired-x)
    (require 'dired+)
    (require 'dired-open)

Open media with the appropriate programs.

    (setq dired-open-extensions
          '(("mkv" . "vlc")
            ("mp4" . "vlc")
            ("avi" . "vlc")))

These are the switches that get passed to *ls* when `dired` gets a list of files. We’re using:

<table border="2" cellspacing="0" cellpadding="6" rules="groups" frame="hsides">


<colgroup>
<col  class="left" />

<col  class="left" />
</colgroup>
<thead>
<tr>
<th scope="col" class="left">Flag</th>
<th scope="col" class="left">Description</th>
</tr>
</thead>

<tbody>
<tr>
<td class="left">l</td>
<td class="left">Use the long listing format.</td>
</tr>


<tr>
<td class="left">h</td>
<td class="left">Use human-readable sizes.</td>
</tr>


<tr>
<td class="left">v</td>
<td class="left">Sort numbers naturally.</td>
</tr>


<tr>
<td class="left">A</td>
<td class="left">Almost all. Doesn’t include ”.” or ”..”.</td>
</tr>
</tbody>
</table>

    (setq-default dired-listing-switches "-lhvA")

Kill buffers of files/directories that are deleted in `dired`.

    (setq dired-clean-up-buffers-too t)

Always copy directories recursively instead of asking every time.

    (setq dired-recursive-copies 'always)

Ask before recursively deleting a directory, though.

    (setq dired-recursive-deletes 'top)

## NeoTree<a id="sec-4-2" name="sec-4-2"></a>

Setting up `NeoTree` and setting [f7] to toggle it. 

    (require 'neotree)
    (global-set-key [f7] 'neotree-toggle)

# PDF-Tools<a id="sec-5" name="sec-5"></a>

Turns `pdf-tools` on after startup

    (add-hook 'after-init-hook 'pdf-tools-install)

# Programming Settings<a id="sec-6" name="sec-6"></a>

## General Settings<a id="sec-6-1" name="sec-6-1"></a>

Make emacs delete on selection

    (delete-selection-mode t)

Require line numbers in all programming models:

    (add-hook 'prog-mode-hook 'linum-mode)

Smaller tab-width:

    (setq-default tab-width 2)

Show matching parenthesis:

    (add-hook 'after-init-hook 'show-paren-mode)

## C/C++ Settings<a id="sec-6-2" name="sec-6-2"></a>

Set the default style to linux for c/c++ programming 

    (setq c-default-style "linux"
          c-basic-offset 4)

# LaTeX<a id="sec-7" name="sec-7"></a>

Turn on `linum-mode` for Latex.

    (add-hook 'latex-mode-hook 'linum-mode)

# Org-Mode<a id="sec-8" name="sec-8"></a>

## Initialization and Hooks<a id="sec-8-1" name="sec-8-1"></a>

Require `Org-mode`.

    (require 'org)

Setting up indenting for all `Org-mode` doc&rsquo;s.

    (add-hook 'org-mode-hook 'org-indent-mode)

Better bullets for org mode.

    (require 'org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

Make org source blocks hae syntax highlighting.

    (setq org-src-fontify-natively t)

Make tabs act as if it were issued in a buffer of the language&rsquo;s major mode.

    ;;(setq org-src-tab-acts-natively t)

Store my org files in ~/org, define the location of an index file (my main todo list), and archive finished tasks in ~/org/archive.org.

    (setq org-directory "~/org")
    
    (defun org-file-path (filename)
      "Return the absolute address of an org file, given its relative name."
      (concat (file-name-as-directory org-directory) filename))
    
    (setq org-inbox-file "~/Dropbox/inbox.org")
    (setq org-index-file (org-file-path "index.org"))
    (setq org-archive-location
          (concat (org-file-path "archive.org") "::* From %s"))

## Task Management<a id="sec-8-2" name="sec-8-2"></a>

I store all my todos in ~/org/index.org, so I’d like to derive my agenda from there.

    (setq org-agenda-files (list org-index-file))

Hitting C-c C-x C-s will mark a todo as done and move it to an appropriate place in the archive.

    (defun hrs/mark-done-and-archive ()
      "Mark the state of an org-mode item as DONE and archive it."
      (interactive)
      (org-todo 'done)
      (org-archive-subtree))
    
    (define-key org-mode-map (kbd "C-c C-x C-s") 'hrs/mark-done-and-archive)

Record the time that a todo was archived.

    (setq org-log-done 'time)

## Exporting<a id="sec-8-3" name="sec-8-3"></a>

Allow export to markdown and beamer (for presentations).

    (require 'ox-md)
    (require 'ox-beamer)
    (require 'ox-twbs)

Allow `babel` to evaluate Emacs lisp, Ruby, dot, or Gnuplot code.

    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (ruby . t)
       (dot . t)
       (gnuplot . t)))

Don&rsquo;t ask before evaluating code blocks.

    (setq org-confirm-babel-evaluate nil)

Associate the &ldquo;dot&rdquo; language with the `graphviz-dot` major mode.

    (add-to-list 'org-src-lang-modes '("dot" . graphviz-dot))

Translate regular ol&rsquo; straight quotes to typographically-correct curly quotes
when exporting.

    (setq org-export-with-smart-quotes t)

### TeX configuration<a id="sec-8-3-1" name="sec-8-3-1"></a>

I rarely write LaTeX directly any more, but I often export through it with
org-mode, so I&rsquo;m keeping them together.

Automatically parse the file after loading it.

    (setq TeX-parse-self t)

Always use `pdflatex` when compiling LaTeX documents. I don&rsquo;t really have any
use for DVIs.

    (setq TeX-PDF-mode t)

Enable a minor mode for dealing with math (it adds a few useful key bindings),
and always treat the current file as the &ldquo;main&rdquo; file. That&rsquo;s intentional, since
I&rsquo;m usually actually in an org document.

    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (LaTeX-math-mode)
                (setq TeX-master t)))

### Exporting to HTML<a id="sec-8-3-2" name="sec-8-3-2"></a>

Don&rsquo;t include a footer with my contact and publishing information at the bottom
of every exported HTML document.

    (setq org-html-postamble nil)

### Exporting to PDF<a id="sec-8-3-3" name="sec-8-3-3"></a>

I want to produce PDFs with syntax highlighting in the code. The best way to do
that seems to be with the `minted` package, but that package shells out to
`pygments` to do the actual work. `pdflatex` usually disallows shell commands;
this enables that.

    (setq org-latex-pdf-process
          '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
            "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

Include the `minted` package in all of my LaTeX exports.

    (add-to-list 'org-latex-packages-alist '("" "minted"))
    (setq org-latex-listings 'minted)

Include the `xcolors` package to all o my LaTeX exports.

    (add-to-list 'org-latex-packages-alist '("usenames,dvipsnames,svgnames" "xcolor"))
      ;;(setq org-latex-listings 'minted)

    (setq org-latex-minted-options
               '(("frame" "lines")
                 ("fontsize" "\\scriptsize")
                 ("bgcolor" "LightGray")))

    (setq org-src-fontify-natively t)

## Visuals<a id="sec-8-4" name="sec-8-4"></a>

I prefer the tables to be significantly different from the colors used as the indentations.

    (custom-theme-set-faces 'user
    `(org-table ((t (:foreground "LightCoral")))))

    (custom-theme-set-faces 'user
     `(org-link ((t (:foreground "IndianRed")))))

# Backups<a id="sec-9" name="sec-9"></a>

Backups are put in one directory.

    (setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

# Origami Mode<a id="sec-10" name="sec-10"></a>

Sets up `Origami-mode` for c++ and LaTeX, and sets up key-bindings

    (add-hook 'c++-mode-hook 'origami-mode)
    (add-hook 'latex-mode-hook 'origami-mode)
    (add-hook 'origami-mode-hook (lambda () (local-set-key (kbd "C-;") 'origami-recursively-toggle-node)))
    (add-hook 'origami-mode-hook (lambda () (local-set-key (kbd "C-:") 'origami-toggle-all-nodes)))

# Visuals and Themes<a id="sec-11" name="sec-11"></a>

## Current Theme<a id="sec-11-1" name="sec-11-1"></a>

Load the Tomorrow-eighties theme

    (add-hook 'after-init-hook (lambda () (load-theme 'sanityinc-tomorrow-eighties)))

## Visual Line Mode<a id="sec-11-2" name="sec-11-2"></a>

Turn on the nicer visual line mode.

    (add-hook 'after-init-hook 'global-visual-line-mode)

# Predictive Text<a id="sec-12" name="sec-12"></a>

## Company Mode<a id="sec-12-1" name="sec-12-1"></a>

Turns on `company-mode` on everywhere.

    (add-hook 'after-init-hook 'global-company-mode)

# Compilation Shortcuts<a id="sec-13" name="sec-13"></a>

## Shortcuts<a id="sec-13-1" name="sec-13-1"></a>

Make **C-x C-a** compile in most programming modes.

    (add-hook 'latex-mode-hook (lambda () (local-set-key "\C-x\C-a" 'tex-compile)))
    (add-hook 'c++-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
    (add-hook 'fortran-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
    (add-hook 'c-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))
    (add-hook 'emacs-lisp-mode-hook (lambda () (local-set-key "\C-x\C-a" 'eval-buffer)))

    (add-hook 'graphviz-dot-mode-hook (lambda () (local-set-key "\C-x\C-a" 'compile)))

## Definition of the compile function<a id="sec-13-2" name="sec-13-2"></a>

### `C++-mode` definition.<a id="sec-13-2-1" name="sec-13-2-1"></a>

    (add-hook 'c++-mode-hook
       (lambda ()
          (set (make-local-variable 'compile-command)
               (let ((file (file-name-nondirectory buffer-file-name)))
               (format "%s -o %s %s"
                       (or (getenv "CC") "g++")
                       (file-name-sans-extension file)
                       file)))))

### `Fortran-mode` definition.<a id="sec-13-2-2" name="sec-13-2-2"></a>

    (add-hook 'fortran-mode-hook
              (lambda ()
                (set (make-local-variable 'compile-command)
                (let ((file (file-name-nondirectory buffer-file-name)))
                     (format "%s -o %s %s"
                           (or (getenv "CC") "gfortran -ffree-form")
                           (file-name-sans-extension file)
                           file)))))

## Kill  Compilation Window<a id="sec-13-3" name="sec-13-3"></a>

Gets rid of the annoying window if compilation is successful.

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

# Sensitivity Mode<a id="sec-14" name="sec-14"></a>

A mode that never backs up or saves data

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