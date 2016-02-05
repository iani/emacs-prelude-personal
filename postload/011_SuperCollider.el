(add-to-list 'load-path "~/.emacs.d/personal/packages/sclang/")
(load-file "~/.emacs.d/personal/packages/sclang/sclang.el")
(load-file "~/.emacs.d/personal/packages/sc-snippets/sc-snippets.el")
(require 'sclang)
(require 'sc-snippets)

;;; Directory of SuperCollider support, for quarks, plugins, help etc.
(defvar sc_userAppSupportDir
  (expand-file-name "~/Library/Application Support/SuperCollider"))

;; Make path of sclang executable available to emacs shell load path

;; For Version 3.6.6:
(add-to-list
 'exec-path
 "/Applications/SuperCollider/SuperCollider.app/Contents/Resources/")

;; For Version 3.7:
(add-to-list
 'exec-path
 "/Applications/SuperCollider/SuperCollider.app/Contents/MacOS/")

;; Global keyboard shortcut for starting sclang
(global-set-key (kbd "C-c M-s") 'sclang-start)
;; overrides alt-meta switch command
(global-set-key (kbd "C-c W") 'sclang-switch-to-workspace)

;; Disable switching to default SuperCollider Workspace when recompiling SClang
(setq sclang-show-workspace-on-startup nil)

;; minor modes SuperCollider

(add-hook 'sclang-mode-hook 'rainbow-delimiters-mode)
(add-hook 'sclang-mode-hook 'hl-sexp-mode)
(add-hook 'sclang-mode-hook 'hs-minor-mode)
;; (add-hook 'sclang-mode-hook 'electric-pair-mode)
;; (add-hook 'sclang-mode-hook 'yas-minor-mode)
;; (add-hook 'sclang-mode-hook 'auto-complete-mode)
(add-hook 'sclang-mode-hook 'hl-paren-mode)
