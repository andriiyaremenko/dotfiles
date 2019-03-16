;; Package manager:
;; Initialise package and add Melpa repository

(require 'package)

(setq my-packages
      '(
        darktooth-theme
        company
        omnisharp
        undo-tree
        rainbow-delimiters
        neotree
;        all-the-icons
        flycheck
        magit
        fsharp-mode
        tide
        goto-chg
        evil
        )
      )

;; for gnu repository
(setq package-check-signature nil)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (package-refresh-contents)
  (package-install 'el-get)
  (message "require is")
  (require 'el-get)
  (el-get 'sync))

(add-to-list 'el-get-recipe-path "~/.emacs.d/settings/recipes")
(el-get 'sync my-packages)

(provide 'package_my)
