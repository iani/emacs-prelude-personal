;;; greek_input --- 2018-02-28 04:14:14 PM
;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

(setq default-input-method "greek")
(global-set-key (kbd "s-;") 'toggle-input-method)
(global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 031_greek_input.el ends here
