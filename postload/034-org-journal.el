
;;; Code:

;; Make new-entry keyboard command available also in org-mode:
(global-set-key (kbd "C-c c j") 'org-journal-new-entry)

;; Create files with .org ending to automatically enable org-mode when loading them:
(setq org-journal-file-format "%Y%m%d.org")

;; Include all journal files in agenda:
(setq org-agenda-files `("/Users/iani/Documents/000WORKFILES/PERSONAL/DIARY.org" ,org-journal-dir))

(provide '034-org-journal)
;;; 034-org-journal ends here
