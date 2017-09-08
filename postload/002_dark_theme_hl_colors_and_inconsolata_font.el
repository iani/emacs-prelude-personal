;;; dark_theme_hl_colors_and_inconsolata_font --- 2017-09-08 02:55:35 PM
  ;;; Commentary:

  ;;; Default font: Inconsolata.
  ;;; Preferred face colors for region, hl-line, hl-sexp-face.
  ;;; Work both for zenburn and moe-dark themes.

  ;;; Code:

  (custom-set-faces
   '(default ((t (:family "Inconsolata" :foundry "nil"
                          :width normal :height 120
                          :weight normal :slant normal :underline nil :overline nil
                          :strike-through nil :box nil
                          :inverse-video nil :foreground "#DCDCCC"
                          :background "#3F3F3F" :stipple nil :inherit nil))))
   '(region ((t (:background "thistle4" :foreground nil))))
   ;; following 2 are for moe-light:
   ;; '(hl-line ((t (:background "DarkSlateGray4" :foreground "yellow1"))))
   '(hl-line ((t (:background "red4"))))
   ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
   '(hl-sexp-face ((t (:background "gray10"))))
   )
(provide 'dark_theme_hl_colors_and_inconsolata_font)
;;; 002_dark_theme_hl_colors_and_inconsolata_font.el ends here
