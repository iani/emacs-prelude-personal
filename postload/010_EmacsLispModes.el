;;; EmacsLispModes --- 2017-09-04 09:48:07 AM
  ;;; Commentary:
  ;;; useful minor modes for emacs-lisp

  ;;; Code:
  (prelude-load-require-packages '(smartparens cl litable icicles))

  ;;; note: smartparens is preferable to paredit.
  (require 'smartparens-config)

  (defun whitespace-off ()
    "Make turning whitespace mode off a command callable from key."
    (interactive)
    (whitespace-mode -1))


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
(provide 'EmacsLispModes)
;;; 010_EmacsLispModes.el ends here
