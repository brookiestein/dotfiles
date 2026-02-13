;; -*- lexical-binding: t -*-
;; Melpa
(setq package-archives
	  '(("gnu" . "https://elpa.gnu.org/packages/")
		("melpa" . "https://melpa.org/packages/")))

(eval-when-compile
  (require 'package)
  (package-initialize)
  (unless package-archive-contents
	(package-refresh-contents))
  (require 'use-package)
  (setf use-package-always-ensure t))

;; Packages
;; - Themes
;;   - Catppuccin
(use-package catppuccin-theme
  :ensure t
  :config (setq catppuccin-flavor 'mocha))
;;   - Doom
(use-package doom-themes
  :ensure t)

;; company-mode
(use-package company
  :ensure t
  :config
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  ;; To prevent default down-casing.
  ;; https://emacs.stackexchange.com/questions/10837/how-to-make-company-mode-be-case-sensitive-on-plain-text
  (setq company-dabbrev-downcase nil)
  ;; 2023-01-13 From a Reddit post on mixed case issue.
  (setq company-dabbrev-ignore-case nil)
  (setq company-dabbrev-code-ignore-case nil)
  (add-hook 'after-init-hook 'global-company-mode))
(with-eval-after-load 'company
  (define-key company-active-map
			  (kbd "TAB")
			  #'company-complete-common-or-cycle)
  (define-key company-active-map
			  (kbd "<backtab>")
			  (lambda ()
					 (interactive)
					 (company-complete-common-or-cycle -1))))

;; My C++ workflow.
(defun my/c-c++-style ()
  ;; Set indentation
  (setq-local
   indent-tabs-mode nil
   tab-width 4
   c-basic-offset 4)
  (c-set-offset 'block-close 0)
  (c-set-offset 'substatement-open 0)
  ;; Autocomplete parenthesis
  (electric-pair-mode t)
  ;; Don't reindent when pressing RET.
  (electric-indent-local-mode -1)
  (electric-layout-local-mode -1)
  ;; C/C++ coding style
  (setq c-default-style "k&r"))
(add-hook 'c-mode-common-hook #'my/c-c++-style)

;; Eglot
(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
			   '((c-mode c++-mode) . ("clangd" "--compile-commands-dir=build"))))
(defun my/c-c++-eglot-setup ()
  (eglot-ensure)
  (add-hook 'before-save-hook
			(lambda ()
			  (when (eglot-current-server)
				(eglot-format-buffer)))
			nil t))
(add-hook 'c-mode-hook #'my/c-c++-eglot-setup)
(add-hook 'c++-mode-hook #'my/c-c++-eglot-setup)

(defun my/cmake-build ()
  (interactive)
  (compile "cmake --build build"))
(defun my/cmake-configure ()
  (interactive)
  (compile "cmake -G Ninja -S . -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON"))
(global-set-key (kbd "<f5>") #'my/cmake-build)
(global-set-key (kbd "<f6>") #'my/cmake-configure)

;; All the icons.
(use-package all-the-icons
  :if (or (display-graphic-p) (daemonp)))
(use-package all-the-icons-dired
  :after dired
  :hook (dired-mode . my/all-the-icons-dired-maybe)
  :config
  (defun my/all-the-icons-dired-maybe ()
    (when (display-graphic-p)
      (all-the-icons-dired-mode 1))))
(use-package all-the-icons-ibuffer
  :if (or (display-graphic-p) (daemonp)))

;; Org mode
(use-package org
  :ensure t
  :config
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture))

;; Markdown mode
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
          ("C-c C-e" . markdown-do)))

;; vterm
(use-package vterm
  :ensure t)
(setenv "TERM" "xterm-256color")
(defun my/vterm-in-current-frame ()
  "Run `vterm` in the currently selected frame. Useful to open emacsclient directly in vterm."
  (interactive)
  (let ((frame (selected-frame)))
    (run-at-time
     "0.5 sec" nil
     (lambda ()
       (when (display-graphic-p frame)
         (with-selected-frame frame
           (condition-case err
               (progn
                 (multi-vterm)
                 (select-window (get-buffer-window (current-buffer)))))
             (error
              (message "Failed to launch vterm: %s" err)))))))
  nil) ;; Return nil to suppress timer object output
;; Open a terminal buffer
(global-set-key (kbd "C-c RET") 'multi-vterm)
(setq vterm-copy-exclude-prompt t)
(setq vterm-ignore-blink-cursor nil)
(setq vterm-max-scrollback 100000)
(define-key vterm-mode-map (kbd "C-q") #'vterm-send-next-key)
;; multi-vterm
(use-package multi-vterm
  :ensure t)
(setq multi-vterm-dedicated-window-height-percent 50)
(add-hook 'buffer-list-update-hook
		  (lambda ()
			(when (string-equal (buffer-name) "vterm")
			  (vterm-reset-cursor-point))))

(defun elevated-find-file (file-name)
  ;; Like find file, but opens the file as root.
  (interactive "FElevated Find File: ")
  (let ((tramp-file-name (concat "/doas::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
(global-set-key (kbd "C-c q f") 'elevated-find-file)

;; PDF tools
(use-package pdf-tools
  :ensure t
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-width)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
  (add-hook 'pdf-view-mode-hook #'pdf-view-roll-minor-mode))
;; Remember page when killing a pdf.
(use-package pdf-view-restore
  :ensure t
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))

;; Make scroll smoother.
(pixel-scroll-precision-mode 1)
(setq pixel-scroll-precision-large-scroll-height 5.0)
;; Disable backup files.
(setf make-backup-files nil)
;; Show line numbers.
(global-display-line-numbers-mode 1)
;; Show column numbers.
(setq column-number-mode t)
;; Highlight current line
(global-hl-line-mode t)
;; Turn on cursor blinking
(blink-cursor-mode t)
;; Save cursor position
(save-place-mode 1)
;; Ensure newline at EOF
(setq require-final-newline t)
;; Delete trailing spaces
(setq delete-trailing-lines nil)
(add-hook 'before-save-hook
		  'delete-trailing-whitespace)
;; Recent edited files
(recentf-mode 1)
(global-set-key (kbd "C-c r") 'recentf-open-files)
;; Save history in minibuffer prompt
(setq history-length 25)
(savehist-mode 1)
;; Don't show the welcome screen at startup
(setq inhibit-startup-message t)
;; Clean Emacs
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; Customize fonts and set theme.
(defun my/apply-gui-config (frame)
  (with-selected-frame frame
    (load-theme 'doom-palenight t)
    (set-frame-font "Jetbrains Mono Nerd Font 12" nil t)))
(if (daemonp)
    (add-hook 'after-make-frame-functions #'my/apply-gui-config)
  (my/apply-gui-config (selected-frame)))
;; Find files case-insensitive.
(setq read-file-name-completion-ignore-case t)
;; Move customization variables to a separate file, so it doesn't get that messy, and load it.
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
