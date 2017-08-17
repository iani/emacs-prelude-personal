;;; org-journal --- 2017-08-17 09:06:07 AM
  ;;; Commentary:
  ;;; use org-journal for capture globally.
  ;;; https://github.com/bastibe/org-journal

  ;;; Code:

  (prelude-load-require-package 'org-journal)

  ;; Create files with .org ending to automatically enable org-mode when loading them:
  (setq org-journal-file-format "%Y%m%d.org")

  (defun org-journal-new-entry-from-org-timestamp ()
    "Like org-journal-new-entry except read time interactively using org-read-date."
    (interactive)
    (org-journal-new-entry nil (apply 'encode-time (org-parse-time-string (org-read-date t t)))))

  (setq org-journal-dir "/Users/iani/Documents/000WORKFILES/PERSONAL/journal")

  ;; Include all journal files in agenda:
  (setq org-agenda-files `("/Users/iani/Documents/000WORKFILES/PERSONAL/DIARY.org" ,org-journal-dir))

  (defun org-journal-at-date-from-user (no-entry)
    "Creat journal entry with date from user, NO-ENTRY prefix enters timestamp without section."
    (interactive "P")
    (let ((time (org-read-date t t)))
      (org-journal-new-entry no-entry time)
      (if no-entry
          (insert "\n" (org-make-time-stamp time t))
          (insert
           "\n :PROPERTIES:\n :DATE: "
           (org-make-time-stamp time t)
           " \n :END:\n"
           ))))

  ;; Make new-entry keyboard command available also in org-mode:
  (global-set-key (kbd "C-c c j") 'org-journal-at-date-from-user)
  (global-set-key (kbd "C-c c J") 'org-journal-new-entry-from-org-timestamp)
(provide 'org-journal)
;;; 024_org-journal.el ends here
