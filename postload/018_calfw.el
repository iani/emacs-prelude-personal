(require 'calfw)
(require 'calfw-org)

;; undo stupid g key binding
(setq cfw:calendar-mode-map
  (cfw:define-keymap
   '(
     ("<right>" . cfw:navi-next-day-command)
     ("f"       . cfw:navi-next-day-command)
     ("<left>"  . cfw:navi-previous-day-command)
     ("b"       . cfw:navi-previous-day-command)
     ("<down>"  . cfw:navi-next-week-command)
     ("n"       . cfw:navi-next-week-command)
     ("<up>"    . cfw:navi-previous-week-command)
     ("p"       . cfw:navi-previous-week-command)

     ;; Vi style
     ("l" . cfw:navi-next-day-command)
     ("h" . cfw:navi-previous-day-command)
     ("j" . cfw:navi-next-week-command)
     ("k" . cfw:navi-previous-week-command)
     ("^" . cfw:navi-goto-week-begin-command)
     ("$" . cfw:navi-goto-week-end-command)

     ("<"   . cfw:navi-previous-month-command)
     ("M-v" . cfw:navi-previous-month-command)
     (">"   . cfw:navi-next-month-command)
     ("C-v" . cfw:navi-next-month-command)
     ("<prior>" . cfw:navi-previous-month-command)
     ("<next>"  . cfw:navi-next-month-command)
     ("<home>"  . cfw:navi-goto-first-date-command)
     ("<end>"   . cfw:navi-goto-last-date-command)

     ("G" . cfw:navi-goto-date-command) ;;  ("g" . cfw:navi-goto-date-command)
     ("t" . cfw:navi-goto-today-command)
     ("." . cfw:navi-goto-today-command)

     ("TAB" . cfw:navi-next-item-command)

     ("g"   . cfw:refresh-calendar-buffer)  ;; ("r"   . cfw:refresh-calendar-buffer)
     ("SPC" . cfw:show-details-command)

     ("D" . cfw:change-view-day)
     ("W" . cfw:change-view-week)
     ("T" . cfw:change-view-two-weeks)
     ("M" . cfw:change-view-month)

     ([mouse-1] . cfw:navi-on-click)

     ("q" . bury-buffer)

     ("0" . digit-argument)
     ("1" . digit-argument)
     ("2" . digit-argument)
     ("3" . digit-argument)
     ("4" . digit-argument)
     ("5" . digit-argument)
     ("6" . digit-argument)
     ("7" . digit-argument)
     ("8" . digit-argument)
     ("9" . digit-argument)

     )))
