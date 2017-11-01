;;; Some useful face color tweaks.
;;; Mainly: Making region, line and sexp higlights visible with high contrast
;;; for dark or for light color themes.

;;; dark blue is more visible for selected region color in moe-dark or zenburn
;;; seashell is better for moe-light
;;; than the default color in zenburn or moe-dark

(custom-set-faces
 ;; the dark blue setting works for moe-light.
 ;; '(region ((t (:background "seashell"))))
 ;; following 2 are for moe-light:
 ;; '(hl-line ((t (:background "papaya whip" :foreground "pale violet red"))))
 '(hl-line ((t (:background "papaya whip"))))
 ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
 '(hl-sexp-face ((t (:background "linen"))))
 )
