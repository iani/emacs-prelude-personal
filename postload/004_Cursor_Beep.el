;;; Cursor_Beep --- 2019-03-24 06:03:21 PM

;;; Commentary:
;;; basic theming, cursor style.

;;; Code:

(setq cursor-type 'bar)   ;; show cursor as thin vertical bar.
(blink-cursor-mode 1)     ;; turn on cursor blinking

(setq visible-bell nil)   ;; instead of ringing a bell ...
(setq ring-bell-function (lambda () ;; .. invert the mode line colors for 1 second
                           (invert-face 'mode-line)
                           (run-with-timer 1 nil 'invert-face 'mode-line)))

(set-cursor-color "tomato")

(provide 'Cursor_Beep)
;;; 004_Cursor_Beep.el ends here
