(menu-bar-mode -1)
(if (functionp 'tool-bar-mode) (toggle-scroll-bar -1))
(if (functionp 'tool-bar-mode) (tool-bar-mode -1))

(setq c-basic-offset 4) ; indents 4 chars
(setq tab-width 4) ; and 4 char wide for TAB
(setq indent-tabs-mode nil) ; And force use of spaces
(turn-on-font-lock) ; same as syntax on in Vim
;; hide welcome screen
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)

;; Recycle Bin
(setq delete-by-moving-to-trash t)

;; Enabling commands to change case
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; El-Get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

; load el-get
(unless (require 'el-get nil 'noerror)
  (with-current-buffer
    (url-retrieve-synchronously
      "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

; user recepies
(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

; el-get install packages
(setq required-packages
      (append
        '(
          undo-tree
          rainbow-delimiters
          neotree
          all-the-icons
          flycheck
          magit
          fsharp-mode
          tide
          goto-chg
          evil
          )
        (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))

(el-get 'sync required-packages)

; install melpa packages
(require 'package)
(require 'cl)

(defvar elpa-packages '(
                        darktooth-theme
                        company
                        omnisharp
                        ))

(defun cfg:install-packages ()
  (let ((pkgs (remove-if #'package-installed-p elpa-packages)))
    (when pkgs
      (message "%s" "Emacs refresh packages database...")
      (package-refresh-contents)
      (message "%s" " done.")
      (dolist (p elpa-packages)
        (package-install p)))))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

; refresh packages
(package-initialize)

; install packages
(cfg:install-packages)

;; theme
(load-theme 'darktooth t)

;; line numbers
(global-display-line-numbers-mode)

;; NEOTree
(add-to-list 'load-path "~/.emacs.d/el-get/neotree")
(global-set-key [(control ?x) (control ?n)] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'icons 'classic))

;; company-mode
(global-company-mode)
(add-hook 'after-init-hook 'global-company-mode)

;; flycheck
(global-flycheck-mode)
(package-install 'exec-path-from-shell)
(exec-path-from-shell-initialize)

;; Omnisharp
(add-hook 'csharp-mode-hook 'omnisharp-mode)
(eval-after-load
  'company
  '(add-to-list 'company-backends 'company-omnisharp))
(add-hook 'csharp-mode-hook #'company-mode)

;; fsharp
(add-to-list 'load-path "~/.emacs.d/el-get/fsharp-mode/")
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

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; undo-tree
(add-to-list 'load-path "~/.emacs.d/el-get/undo-tree")
(global-undo-tree-mode)

;; evil
(evil-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (omnisharp exec-path-from-shell darktooth-theme company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
