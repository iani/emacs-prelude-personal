  ;;; Some useful face color tweaks.
  ;;; Mainly: Making region, line and sexp higlights visible with high contrast
  ;;; for dark or for light color themes.

  ;;; dark blue is more visible for selected region color
  ;;; than the default color in zenburn or moe-dark

(custom-set-faces
 '(region ((t (:background "dark blue"))))
 ;; following 2 are for moe-light:
 '(hl-line ((t (:background "papaya whip" :foreground "pale violet red"))))
 '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4")))))
