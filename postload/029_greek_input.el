;;; greek_input --- 2017-11-01 11:21:20 πμ
;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

(setq default-input-method "greek")
(global-set-key (kbd "s-;") 'toggle-input-method)
(global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 029_greek_input.el ends here
