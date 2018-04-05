;;; greek_input --- 2018-04-05 04:37:59 PM
  ;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

  (setq default-input-method "greek")
  (global-set-key (kbd "s-;") 'toggle-input-method)
  (global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 034_greek_input.el ends here
