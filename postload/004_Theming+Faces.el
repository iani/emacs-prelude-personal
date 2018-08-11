;;; Theming+Faces --- 2018-08-11 01:05:04 PM
  ;;; Commentary:

  ;;; Default font: Inconsolata.
  ;;; Preferred face colors for region, hl-line, hl-sexp-face.
  ;;; Work both for zenburn and moe-dark themes.

  ;;; Code:

  (custom-set-faces
   ;; NOTE: Liberation mono font has fixed width also for greek:
   ;; Org table columns using both greek and latin characters thus align properly with this font.
   ;; Inconsolata and Source Code Pro result in misaligned table columns when mixing greek and latin characters.
   '(default ((t (:family
                  ;; "Liberation Mono for Powerline"
                  "Courier New"
                  :foundry "nil"
                  :width normal :height 110
                  :weight normal :slant normal :underline nil :overline nil
                  :strike-through nil :box nil
                  :inverse-video nil :foreground "#DCDCCC"
                  :background "#3F3F3F" :stipple nil :inherit nil))))
   '(helm-selection ((t
                      (:underline nil :background "MediumOrchid1" :foreground "white"))))
   '(region ((t (:background "thistle4" :foreground nil))))
   ;; following 2 are for moe-light:
   ;; '(hl-line ((t (:background "DarkSlateGray4" :foreground "yellow1"))))
   '(hl-line ((t (:background "red4"))))
   ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
   '(hl-sexp-face ((t (:background "gray10")))))

  (powerline-moe-theme)
  (moe-dark)
(provide 'Theming+Faces)
;;; 004_Theming+Faces.el ends here
