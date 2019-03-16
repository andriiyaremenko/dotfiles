;; company-mode
(global-company-mode)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-tooltip-align-annotations t) ; aligns annotation to the right hand side

;; Omnisharp
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
  'company
  '(add-to-list 'company-backends 'company-omnisharp))
(add-hook 'csharp-mode-hook #'company-mode)

;; flycheck
(global-flycheck-mode)
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; fsharp
(autoload 'fsharp-mode "fsharp-mode"     "Major mode for editing F# code." t)
(add-to-list 'auto-mode-alist '("\\.fs[iylx]?$" . fsharp-mode))
(add-hook 'fsharp-mode-hook
 (lambda ()
   (define-key fsharp-mode-map [(control ?c) (control ?o)] 'fsharp-ac/complete-at-point)))
(add-hook 'fsharp-mode-hook 'highlight-indentation-mode)

;; tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))
;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; undo-tree
(global-undo-tree-mode)

;; evil
(evil-mode 1)

(provide 'hooks_my)
