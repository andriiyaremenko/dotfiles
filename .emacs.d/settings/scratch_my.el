;; Disable GUI components
(when (display-graphic-p)
  (tool-bar-mode    -1)
  (scroll-bar-mode  -1)
  ;; Fringe settings
  (fringe-mode '(8 . 0))
  (setq-default indicate-buffer-boundaries 'left)
  )

(tooltip-mode     -1)
(menu-bar-mode    -1)
(setq use-dialog-box        nil
      redisplay-dont-pause  t
      ring-bell-function    'ignore)

;; Display the name of the current buffer in the title bar
(setq frame-title-format "%b")

;; Disable backup/autosave files
(setq backup-inhibited          t
      make-backup-files         nil
      auto-save-default         nil
      auto-save-list-file-name  nil)

;; Coding-system settings
(set-language-environment               'UTF-8)
(setq buffer-file-coding-system         'utf-8
      file-name-coding-system           'utf-8)
(setq-default coding-system-for-read    'utf-8)
(set-selection-coding-system            'utf-8)
(set-keyboard-coding-system             'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(prefer-coding-system                   'utf-8)

(setq-default display-line-numbers t)

;; indent
(setq c-basic-offset 4) ; indents 4 chars
(setq tab-width 4) ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces
(turn-on-font-lock) ; same as syntax on in Vim

;; Enabling commands to change case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; line numbers
(global-display-line-numbers-mode)

(provide 'scratch_my)
