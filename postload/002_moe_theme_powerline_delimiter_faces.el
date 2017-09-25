;;; moe_theme_powerline_delimiter_faces --- 2017-09-25 06:02:00 AM
  ;;; Commentary:
  ;;; moe-theme

  ;;; Code:
  (prelude-load-require-package 'moe-theme)
  (setq powerline-moe-theme t)
  (moe-dark)
  (require'powerline)
  (powerline-default-theme)
  (custom-set-faces
   '(info-title-3 ((t (:inherit info-title-4 :foreground "white" :height 1.2))))
   '(info-title-4 ((t (:inherit info-title-4 :foreground "red"))))
   '(font-lock-variable-name-face ((t
                                    (:foreground "turquoise2"))))
   '(font-lock-comment-delimiter-face ((t
                              (:slant italic :foreground "SeaGreen4"))))
   '(font-lock-comment-face ((t
                              (:slant italic :foreground "coral1"))))
   '(mode-line ((t (
                    :background "DarkCyan"
                                :foreground "tomato"
                                :box (:line-width 1 :color "turquoise3")
                                :weight light :height 118 :family "Monospace")))))
(provide 'moe_theme_powerline_delimiter_faces)
;;; 002_moe_theme_powerline_delimiter_faces.el ends here
