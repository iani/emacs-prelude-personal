;;; selected_region_color_blue --- 2017-09-04 09:48:04 AM
  ;;; Commentary:

  ;;; Some useful face color tweaks.
  ;;; Mainly: Making region, line and sexp higlights visible with high contrast
  ;;; for dark or for light color themes.

  ;;; dark blue is more visible for selected region color
  ;;; than the default color in zenburn or moe-dark

  ;;; Code:

  (custom-set-faces
   '(region ((t (:background "dark blue"))))
   ;; following 2 are for moe-light:
   ;; '(hl-line ((t (:background "papaya whip" :foreground "pale violet red"))))
   ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
   )
(provide 'selected_region_color_blue)
;;; 002_selected_region_color_blue.el ends here
