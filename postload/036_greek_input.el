;;; greek_input --- 2018-12-20 06:36:49 AM
  ;; (global-set-key (kbd "C-c C-\\") 'toggle-input-method)

  (setq default-input-method "greek")
  (global-set-key (kbd "s-;") 'toggle-input-method)
  (global-set-key (kbd "s-\\") 'toggle-input-method)

(provide 'greek_input)
;;; 036_greek_input.el ends here
