;;; EmacsLispModes_and_whitespace_off --- 2017-11-02 11:01:27 πμ
;;; Commentary:
;;; useful minor modes for emacs-lisp

;;; Code:
(prelude-load-require-packages '(smartparens cl litable icicles))

;;; note: smartparens is preferable to paredit.
(require 'smartparens-config)

(add-hook 'emacs-lisp-mode-hook 'hl-sexp-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(global-set-key (kbd "H-l h") 'hs-hide-level)
(global-set-key (kbd "H-l s") 'hs-show-all)

(add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode)
(add-hook 'emacs-lisp-mode-hook 'whitespace-off)

(add-hook 'emacs-lisp-mode-hook 'smartparens-mode)
;; (add-hook 'emacs-lisp-mode-hook 'turn-on-whitespace-mode)
(add-hook 'emacs-lisp-mode-hook 'auto-complete-mode)
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)

;; H-C-i:
(define-key emacs-lisp-mode-map (kbd "H-i") 'icicle-imenu-command)
(provide 'EmacsLispModes_and_whitespace_off)
;;; 014_EmacsLispModes_and_whitespace_off.el ends here
