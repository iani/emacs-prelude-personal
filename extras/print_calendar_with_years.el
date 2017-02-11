;;; package --- print-calendar

;;; Commentary:

;; Hack for printing weekly calendar with year name appended to each day

;; Use t w 1 command (cal-tex-cursor-week) on calendar to create latex file.
;; Use prefix for number of weeks to generate.
;; Then save the latex file, and type C-c C-c to render the file to pdf.

;; Following patch/override of function cal-tex-week-hours just adds the year after the day number for each day.

;;; Code:

(defun cal-tex-week-hours (date holidays height)
  "Insert hourly entries for DATE with HOLIDAYS, with line height HEIGHT.
Uses the 24-hour clock if `cal-tex-24' is non-nil.  Note that the hours
shown are hard-coded to 8-12, 13-17."
  (let ((month (calendar-extract-month date))
        (day (calendar-extract-day date))
        (year (calendar-extract-year date))
        morning afternoon s)
  (cal-tex-comment "begin cal-tex-week-hours")
  (cal-tex-cmd  "\\ \\\\[-.2cm]")
  (cal-tex-cmd "\\noindent")
  (cal-tex-b-parbox "l" "6.8in")
  (cal-tex-large-bf (cal-tex-LaTeXify-string (calendar-day-name date)))
  (insert ", ")
  (cal-tex-large-bf (cal-tex-month-name month))
  (insert " ")
  ;; hack next s-exp: add year name string after day
  ;; (cal-tex-large-bf (number-to-string day)) ;; replace with:
  (cal-tex-large-bf (concat (number-to-string day) " " (number-to-string year)))
  (unless (string-equal "" (setq s (cal-tex-latexify-list
                                    holidays date "; ")))
    (insert ": ")
    (cal-tex-large-bf s))
  (cal-tex-hfill)
  (insert " " (eval cal-tex-daily-string))
  (cal-tex-e-parbox)
  (cal-tex-nl "-.3cm")
  (cal-tex-rule "0pt" "6.8in" ".2mm")
  (cal-tex-nl "-.1cm")
  (dotimes (i 5)
    (setq morning (+ i 8)               ; 8-12 incl
          afternoon (if cal-tex-24
                        (+ i 13)        ; 13-17 incl
                      (1+ i)))          ; 1-5 incl
    (cal-tex-cmd "\\hourbox" (number-to-string morning))
    (cal-tex-arg height)
    (cal-tex-hspace ".4cm")
    (cal-tex-cmd "\\hourbox" (number-to-string afternoon))
    (cal-tex-arg height)
    (cal-tex-nl))))

(provide '035-print-calendar)
;;; 035-print-calendar.el ends here
