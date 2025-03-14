;; Disable backup files.
(setf make-backup-files nil)
;; Show line numbers.
(global-display-line-numbers-mode 1)
;; Save cursor position
(save-place-mode 1)
;; Set indentation
(setq-default
 indent-tabs-mode t
 tab-stop-list (number-sequence 4 200 4)
 tab-width 4
 indent-line-function 'insert-tab)
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

(use-package timu-spacegrey-theme
  :ensure t
  :config
  (load-theme 'timu-spacegrey t))

(use-package typescript-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
