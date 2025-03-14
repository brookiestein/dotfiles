;; Disable backup files.
(setf make-backup-files nil)
;; Show line numbers.
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
;; Save cursor position
(save-place-mode 1)
