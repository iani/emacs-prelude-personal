(require 'moe-theme)
(setq powerline-moe-theme t)
(moe-dark)
(require 'powerline)
(powerline-default-theme)
(custom-set-faces
 '(info-title-3 ((t (:inherit info-title-4 :foreground "white" :height 1.2))))
 '(info-title-4 ((t (:inherit info-title-4 :foreground "red"))))
 '(mode-line ((t (
                  :background "DarkCyan"
                              :foreground "tomato"
                              :box (:line-width 1 :color "turquoise3")
                              :weight light :height 118 :family "Monospace")))))

(blink-cursor-mode 1)     ;; turn on cursor blinking

(setq visible-bell nil)   ;; instead of ringing a bell ...
(setq ring-bell-function (lambda () ;; .. invert the mode line colors for 1 second
                           (invert-face 'mode-line)
                           (run-with-timer 1 nil 'invert-face 'mode-line)))

