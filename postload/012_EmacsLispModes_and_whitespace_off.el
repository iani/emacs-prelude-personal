;;; EmacsLispModes_and_whitespace_off --- 2017-10-03 10:57:22 AM
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

  (add-hook 'markdown-mode-hook 'whitespace-off)
  ;; H-C-i:
  (define-key emacs-lisp-mode-map (kbd "H-i") 'icicle-imenu-command)
(provide 'EmacsLispModes_and_whitespace_off)
;;; 012_EmacsLispModes_and_whitespace_off.el ends here
