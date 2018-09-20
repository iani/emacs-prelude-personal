;;; greek_input --- 2018-09-20 11:34:51 AM
  ;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

  (setq default-input-method "greek")
  (global-set-key (kbd "s-;") 'toggle-input-method)
  (global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 035_greek_input.el ends here
