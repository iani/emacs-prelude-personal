;;; Theming+Faces --- 2019-03-24 06:03:21 PM
  ;;; Commentary:

  ;; Theme tweaking is a time-consuming and frustrating pasttime.
  ;; Avoid if possible.

  ;;; Code:

  (custom-set-faces
   ;; NOTE: Liberation mono font has fixed width also for greek:
   ;; Org table columns using both greek and latin characters thus align properly with this font.
   ;; Inconsolata and Source Code Pro result in misaligned table columns when mixing greek and latin characters.
   '(default ((t (:family
                  ;; "Liberation Mono for Powerline"
                  ;; "Courier New"
                  ;; "Ubuntu Mono derivative Powerline"
                  "Ubuntu Mono"
                  :foundry "nil"
                  :width normal :height 140
                  :weight normal :slant normal :underline nil :overline nil
                  :strike-through nil :box nil
                  ;; :inverse-video nil :foreground "#DCDCCC"
                  ;; :background "#3F3F3F" :stipple nil :inherit nil

                  )))))

  ;;; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ;;; following often caused a mess:

  ;; '(helm-selection ((t
  ;;                    (:underline nil :background "MediumOrchid1" :foreground "white"))))
  ;; '(region ((t (:background "thistle4" :foreground nil))))
  ;; following 2 are for moe-light:
  ;; '(hl-line ((t (:background "DarkSlateGray4" :foreground "yellow1"))))
  ;; '(hl-line ((t (:background "red4"))))
  ;; '(hl-sexp-face ((t (:background "linen" :foreground "VioletRed4"))))
  ;; '(hl-sexp-face ((t (:background "gray10"))))

  ;; (powerline-moe-theme)
  ;; (moe-dark)
(provide 'Theming+Faces)
;;; 003_Theming+Faces.el ends here
