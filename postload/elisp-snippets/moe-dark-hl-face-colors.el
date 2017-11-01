;;; Some useful face color tweaks.
;;; Mainly: Making region, line and sexp higlights visible with high contrast
;;; for dark or for light color themes.

;;; dark blue is more visible for selected region color in moe-dark or zenburn
;;; seashell is better for moe-light
;;; than the default color in zenburn or moe-dark

(custom-set-faces
 ;; the dark blue setting works for moe-light.
 '(helm-selection ((t
                    (:underline nil :background "MediumOrchid1"))))
 '(region ((t (:background "thistle4" :foreground nil))))
 ;; following 2 are for moe-light:
 ;; '(hl-line ((t (:background "DarkSlateGray4" :foreground "yellow1"))))
 '(hl-line ((t (:background "red4"))))
 ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
 '(hl-sexp-face ((t (:background "gray10"))))
 )
