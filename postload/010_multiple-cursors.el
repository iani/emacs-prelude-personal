;;; multiple-cursors --- 2018-02-28 04:14:08 PM

(prelude-load-require-packages '(multiple-cursors mc-extras ace-mc))

;; ace-mc
(global-set-key (kbd "C-c )") 'ace-mc-add-multiple-cursors)
(global-set-key (kbd "C-M-)") 'ace-mc-add-single-cursor)

;; multiple-cursors

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
;; mc-extras

(define-key mc/keymap (kbd "C-. C-d") 'mc/remove-current-cursor)
(define-key mc/keymap (kbd "C-. d")   'mc/remove-duplicated-cursors)

(define-key mc/keymap (kbd "C-. C-.") 'mc/freeze-fake-cursors-dwim)

(define-key mc/keymap (kbd "C-. =")   'mc/compare-chars)

;; Emacs 24.4+ comes with rectangle-mark-mode.
(define-key rectangle-mark-mode-map (kbd "C-. C-,")
  'mc/rect-rectangle-to-multiple-cursors)

(define-key cua--rectangle-keymap   (kbd "C-. C-,")
  'mc/cua-rectangle-to-multiple-cursors)

(mc/cua-rectangle-setup)
(provide 'multiple-cursors)
;;; 010_multiple-cursors.el ends here
