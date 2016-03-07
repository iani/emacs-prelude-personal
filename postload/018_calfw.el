(require 'calfw)
(require 'calfw-org)

(setq calendar-christian-all-holidays-flag t)

(setq org-capture-use-agenda-date t)

(setq cfw:org-overwrite-default-keybinding t)

(defun org-calfw-here ()
  "Open calfw on the file of the present buffer."
  (interactive)
  (setq org-agenda-files (list (buffer-file-name)))
  (org-log-here (buffer-file-name) t)
  (cfw:open-org-calendar))

(defun cfw:org-capture ()
  "Overwrite original to run own cfw:org-capture-at-date instead."
  (interactive)
  (cfw:org-capture-at-date))

(defun cfw:org-capture-at-date ()
  "Run org-capture with ORG-OVERRIDING-DEFAULT-TIME from cursor."
  (interactive)
  (with-current-buffer  (get-buffer-create cfw:calendar-buffer-name)
    (let* ((pos (cfw:cursor-to-nearest-date))
           (org-overriding-default-time
            (encode-time 0 0 7
                         (calendar-extract-day pos)
                         (calendar-extract-month pos)
                         (calendar-extract-year pos))))
      (org-capture))))




