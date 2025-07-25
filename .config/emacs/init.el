;; -*- lexical-binding: t -*-
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
(use-package catppuccin-theme
  :ensure t
  :config (setq catppuccin-flavor 'mocha))

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

;; Org mode
(use-package org
  :ensure t
  :config
  (global-set-key (kbd "C-c l") #'org-store-link)
  (global-set-key (kbd "C-c a") #'org-agenda)
  (global-set-key (kbd "C-c c") #'org-capture)
)

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

;; emms
(use-package emms
  :ensure t
  :init
  (add-hook 'emms-player-started-hook 'emms-show)
  :config
  (require 'emms-setup)
  (emms-all) ;; sets up all the standard modules
  (require 'emms-player-mpv) ;; use mpv backend

  (setq emms-show-format "Playing: %s")
  (setq emms-player-list '(emms-player-mpv)
        emms-info-functions '(emms-info-native)
        emms-source-file-default-directory "~/Music/")

  (setq emms-source-file-extensions '("mp3" "ogg" "flac" "wav" "m4a"))

  ;; Load your music recursively
  (defun my/emms-load-music ()
    ;; Recursively add all music files from the default directory.
    (interactive)
    (emms-add-directory-tree emms-source-file-default-directory))

  (defun my/emms-notify-current-song ()
  ;; Send a desktop notification with the current song info.
  (let ((track (emms-playlist-current-selected-track)))
    (when track
      (let ((title (emms-track-get track 'info-title))
            (artist (emms-track-get track 'info-artist)))
        (start-process "emms-notify" nil "notify-send"
					   "-u" "low" "-t" "5000"
                       "Now Playing"
                       (if (and artist title)
                           (format "%s - %s" artist title)
                         (emms-track-description track)))))))

  (add-hook 'emms-player-started-hook #'my/emms-notify-current-song)

  :bind
  (("C-c w m e" . emms)
   ("C-c w m s" . emms-stop)
   ("C-c w m l" . my/emms-load-music) ;; First load all songs from the default directory. This is needed before starting emms.
   ("<XF86AudioPrev>" . emms-previous)
   ("<XF86AudioNext>" . emms-next)
   ("<XF86AudioPlay>" . emms-pause)
   ("<XF86AudioPause>" . emms-pause)))

(defun sudo-find-file (file-name)
  ;; Like find file, but opens the file as root.
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
(global-set-key (kbd "C-c q f") 'sudo-find-file)

;; Disable backup files.
(setf make-backup-files nil)
;; Show line numbers.
(global-display-line-numbers-mode 1)
;; Highlight current line
(global-hl-line-mode t)
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
;; Customize fonts and set theme.
(defun my/apply-gui-config (frame)
  (with-selected-frame frame
    (load-theme 'catppuccin t)
    (set-frame-font "Jetbrains Mono Nerd Font 12" nil t)))
(if (daemonp)
    (add-hook 'after-make-frame-functions #'my/apply-gui-config)
  (my/apply-gui-config (selected-frame)))
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
;; Move customization variables to a separate file, so it doesn't get that messy, and load it.
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
