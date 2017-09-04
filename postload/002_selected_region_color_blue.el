;;; selected_region_color_blue --- 2017-09-04 12:04:53 PM
  ;;; Commentary:

  ;;; Preferred face colors for region, hl-line, hl-sexp-face.
  ;;; Work both for zenburn and moe-dark themes.

  ;;; Code:

  (custom-set-faces
   '(region ((t (:background "thistle4" :foreground nil))))
   ;; following 2 are for moe-light:
   ;; '(hl-line ((t (:background "DarkSlateGray4" :foreground "yellow1"))))
   '(hl-line ((t (:background "red4"))))
   ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
   '(hl-sexp-face ((t (:background "gray10"))))
   )
(provide 'selected_region_color_blue)
;;; 002_selected_region_color_blue.el ends here
