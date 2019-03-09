;;; last_actions_1_window_hydra_global_hl_dark --- 2019-03-09 04:18:35 PM
  (delete-other-windows)
  (hydra-global/body)
  ;; set faces to harmonize with prelude's default zenburn color theme
  ;; (custom-set-faces
  ;;  '(region ((t
  ;;             (:background "#454A35"))))
  ;;  '(org-link ((t
  ;;               (:underline
  ;;                (:color "cyan" :style line)
  ;;                :foreground "cyan"))))
  ;;  '(org-block ((t
  ;;                (:foreground "#9bff7" :background "#17271f"))))
  ;;  '(hl-line ((t (:background "gray0"))))
  ;;  '(hl-sexp-face ((t (:background "gray10"))))
  ;;  '(org-block-end-line ((t (:background "#2a2a2f" :foreground "gray99"))) t)
  ;;  '(org-block-begin-line ((t (:background "#3a2a2f" :foreground "gray99"))) t))

  ;; make buffer name more visible in powerline moe theme
  (set-face-attribute 'mode-line-buffer-id nil :background nil :foreground "#F81808")
(provide 'last_actions_1_window_hydra_global_hl_dark)
;;; 042_last_actions_1_window_hydra_global_hl_dark.el ends here
