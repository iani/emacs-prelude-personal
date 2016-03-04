(require 'calfw)
(require 'calfw-org)

(setq org-capture-use-agenda-date t)

(setq cfw:org-overwrite-default-keybinding t)

(defun org-calfw-here ()
  "Open calfw on the file of the present buffer."
  (interactive)
  (setq org-agenda-files (list (buffer-file-name)))
  (org-log-here (buffer-file-name) t)
  (cfw:open-org-calendar))

;; (defun cfw:goto-date ()
;;   "Input date and go to it in calfw.
;; Better input facility using org-read-date"
;;   (interactive)
;;   (cfw:navi-goto-date
;;    (let*
;;        ((date-parsed
;;          (read
;;           (format
;;            "(%s)"
;;            (replace-regexp-in-string "-" " " (org-read-date)))))
;;         (year (first date-parsed))
;;         (month (second date-parsed))
;;         (day (third date-parsed)))
;;      (list month day year))))


