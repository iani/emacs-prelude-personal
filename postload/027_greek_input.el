;;; greek_input --- 2017-10-12 04:23:13 AM
  ;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

  (setq default-input-method "greek")
  (global-set-key (kbd "s-;") 'toggle-input-method)
  (global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 027_greek_input.el ends here
