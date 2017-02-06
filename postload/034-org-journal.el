
;;; Code:

;; Make new-entry keyboard command available also in org-mode:
(global-set-key (kbd "C-c c j") 'org-journal-new-entry)
(global-set-key (kbd "C-c c J") 'org-journal-new-entry-from-org-timestamp)

(defun org-journal-new-entry-from-org-timestamp (prefix)
  "Like org-journal-new-entry except read time interactively using org-read-date."
  (interactive "P")
  (org-journal-new-entry prefix (apply 'encode-time (org-parse-time-string (org-read-date)))))

;; Create files with .org ending to automatically enable org-mode when loading them:
(setq org-journal-file-format "%Y%m%d.org")

(setq org-journal-dir "/Users/iani/Documents/000WORKFILES/PERSONAL/journal")

;; Include all journal files in agenda:
(setq org-agenda-files `("/Users/iani/Documents/000WORKFILES/PERSONAL/DIARY.org" ,org-journal-dir))

(provide '034-org-journal)
;;; 034-org-journal ends here

