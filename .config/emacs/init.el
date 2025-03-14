;; Disable backup files.
(setf make-backup-files nil)
;; Show line numbers.
(global-display-line-numbers-mode 1)
;; Save cursor position
(save-place-mode 1)
;; Set indentation
(setq-default indent-tabs-mode nil)
;; (setq-default tab-width 4)
(setq-default
 indent-tabs-mode t
 tab-stop-list (number-sequence 4 200 4)
 tab-width 4
 indent-line-function 'insert-tab)
;; Coding style
(setq c-default-style "linux")
(c-set-offset 'comment-intro 0)
