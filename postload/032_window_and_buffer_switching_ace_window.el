;;; window_and_buffer_switching_ace_window --- 2018-02-28 04:14:15 PM
;;; Commentary:
;;; move amngst windows and switch window position with cursor keys

(prelude-load-require-package 'buffer-move)
;; (require 'windmove) required by buffermove
;; (winner-mode -1)
(global-set-key (kbd "s-<left>")  'windmove-left)
(global-set-key (kbd "s-<right>") 'windmove-right)
(global-set-key (kbd "s-<up>")    'windmove-up)
(global-set-key (kbd "s-<down>")  'windmove-down)
(global-set-key (kbd "s-S-<up>")     'buf-move-up)
(global-set-key (kbd "s-S-<down>")   'buf-move-down)
(global-set-key (kbd "s-S-<left>")   'buf-move-left)
(global-set-key (kbd "s-S-<right>")  'buf-move-right)
(global-set-key (kbd "C-O")  'ace-window)
(global-set-key (kbd "C-x o")  'ace-window)
(setq aw-keys '(?a ?b ?c ?d ?e ?f ?g ?h ?i ?j ?k ?l ?m ?n ?o ?p ?q))

;; (require 'use-package)
;; (use-package
;;  ace-window
;;  :ensure ace-window
;;  :config (setq aw-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s))
;;  :bind ("C-x o") . ace-window)
(provide 'window_and_buffer_switching_ace_window)
;;; 032_window_and_buffer_switching_ace_window.el ends here
