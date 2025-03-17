;; Melpa
(setq package-archives
	  '(("gnu" . "https://elpa.gnu.org/packages/")
		("melpha" . "https://melpa.org/packages/")))

(eval-when-compile
  (require 'package)
  (package-initialize)
  (unless package-archive-contents
	(package-refresh-contents))
  (require 'use-package)
  (setf use-package-always-ensure t))

;; Packages
(use-package timu-spacegrey-theme
  :ensure t
  :config
  (load-theme 'timu-spacegrey t))

;; To do web dev like the chads do.
(use-package typescript-mode)

;; company-mode
(use-package company
  :ensure t)

(company-mode 1)
(add-hook 'after-init-hook 'global-company-mode)
(with-eval-after-load 'company
  (define-key company-active-map
			  (kbd "TAB")
			  #'company-complete-common-or-cycle)
  (define-key company-active-map
			  (kbd "<backtab>")
			  (lambda ()
					 (interactive)
					 (company-complete-common-or-cycle -1))))

;; Disable backup files.
(setf make-backup-files nil)
;; Show line numbers.
(global-display-line-numbers-mode 1)
;; Highlight current line
(hl-line-mode t)
;; Turn on cursor blinking
(blink-cursor-mode t)
;; Save cursor position
(save-place-mode 1)
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
;; Customize fonts
(set-frame-font "Jetbrains Mono Nerd Font 12")
;; Set indentation
(setq-default
 indent-tabs-mode t
 tab-stop-list (number-sequence 4 200 4)
 tab-width 4
 indent-line-function 'insert-tab)
;; Autocomplete parenthesis
(electric-pair-mode t)
;; Autoindent on new line
(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'c-mode-hook 'set-newline-and-indent)
;; C/C++ coding style
(setq c-default-style "k&r")
;; Find files case-insensitive.
(setq read-file-name-completion-ignore-case t)
;; Open a terminal buffer
(global-set-key (kbd "C-c RET") 'shell)
;; Move customization variables to a separate file, so it doesn't get that messy, and load it.
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
