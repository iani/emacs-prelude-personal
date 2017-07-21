;; see: http://sachachua.com/blog/2014/05/emacs-chat-bozhidar-batsov/
;; and https://github.com/purcell/elisp-slime-nav
(require 'elisp-slime-nav)
(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode))
