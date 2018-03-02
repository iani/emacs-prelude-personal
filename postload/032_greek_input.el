;;; greek_input --- 2018-03-02 06:19:42 PM
;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

(setq default-input-method "greek")
(global-set-key (kbd "s-;") 'toggle-input-method)
(global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 032_greek_input.el ends here
