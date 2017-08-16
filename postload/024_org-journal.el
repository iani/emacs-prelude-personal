;;; org-journal --- 2017-08-17 08:00:43 AM
  ;;; Commentary:
  ;;; use org-journal for capture globally.
  ;;; https://github.com/bastibe/org-journal

  ;;; Code:

  (prelude-load-require-package 'org-journal)

  ;; Make new-entry keyboard command available also in org-mode:
  (global-set-key (kbd "C-c c j") 'org-journal-at-date-from-user)
  (global-set-key (kbd "C-c c J") 'org-journal-new-entry-from-org-timestamp)

  (defun org-journal-new-entry-from-org-timestamp (prefix)
    "Like org-journal-new-entry except read time interactively using org-read-date."
    (interactive "P")
    (org-journal-new-entry prefix (apply 'encode-time (org-parse-time-string (org-read-date t t)))))

  ;; Create files with .org ending to automatically enable org-mode when loading them:
  (setq org-journal-file-format "%Y%m%d.org")

  (setq org-journal-dir "/Users/iani/Documents/000WORKFILES/PERSONAL/journal")

  ;; Include all journal files in agenda:
  (setq org-agenda-files `("/Users/iani/Documents/000WORKFILES/PERSONAL/DIARY.org" ,org-journal-dir))

  (provide '034-org-journal)
  ;;; 034-org-journal ends here

  (defun org-journal-at-date-from-user (prefix)
    "Run org-journal-new-entry with ORG-OVERRIDING-DEFAULT-TIME from cursor."
    (interactive "P")
    (with-current-buffer  (get-buffer-create cfw:calendar-buffer-name)
      (let* (
             ;; (pos (cfw:cursor-to-nearest-date))
             (org-overriding-default-time
              (org-read-date t t)
              ;; (encode-time 0 0 7
              ;;              (calendar-extract-day pos)
              ;;              (calendar-extract-month pos)
              ;;              (calendar-extract-year pos))
              ))
        (org-journal-new-entry prefix org-overriding-default-time)
        (unless prefix
          (org-set-property-and-value "DATE" )
          (org-make-time-stamp org-overriding-default-time t)
          ;; (backward-word)
          ;; (backward-word)
          ;; (paredit-forward-kill-word)
          ;; (paredit-forward-kill-word)
          ))))

  (defun org-make-time-stamp (time &optional with-hm inactive pre post extra)
    "Make a date stamp for the date given by the internal TIME.
  Adapted from org-insert-time-stamp for use with org-set-property.
  See `format-time-string' for the format of TIME.
  WITH-HM means use the stamp format that includes the time of the day.
  INACTIVE means use square brackets instead of angular ones, so that the
  stamp will not contribute to the agenda.
  PRE and POST are optional strings to be inserted before and after the
  stamp.
  The command returns the inserted time stamp."
    (let ((fmt (funcall (if with-hm 'cdr 'car) org-time-stamp-formats))
          stamp)
      (when inactive (setq fmt (concat "[" (substring fmt 1 -1) "]")))
      (insert-before-markers (or pre ""))
      (when (listp extra)
        (setq extra (car extra))
        (if (and (stringp extra)
                 (string-match "\\([0-9]+\\):\\([0-9]+\\)" extra))
            (setq extra (format "-%02d:%02d"
                                (string-to-number (match-string 1 extra))
                                (string-to-number (match-string 2 extra))))
          (setq extra nil)))
      (when extra
        (setq fmt (concat (substring fmt 0 -1) extra (substring fmt -1))))
      (setq stamp (concat (format-time-string fmt time)) (or post ""))
      (setq org-last-inserted-timestamp stamp)
      stamp))
(provide 'org-journal)
;;; 024_org-journal.el ends here
