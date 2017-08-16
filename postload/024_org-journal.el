;;; org-journal --- 2017-08-16 01:46:02 PM
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
          (org-insert-time-stamp org-overriding-default-time t)
          ;; (backward-word)
          ;; (backward-word)
          ;; (paredit-forward-kill-word)
          ;; (paredit-forward-kill-word)
          ))))
(provide 'org-journal)
;;; 024_org-journal.el ends here
