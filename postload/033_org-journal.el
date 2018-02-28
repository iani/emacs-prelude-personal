;;; org-journal --- 2018-02-28 04:14:15 PM
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

;; Overwrite custom setting of var:
(setq org-journal-dir (file-truename "~/Documents/000WORKFILES/PERSONAL/journal"))

;; adding own custom var to journal group, using template from journal mode.
(defcustom org-todo-dir (file-truename "~/Documents/000WORKFILES/PERSONAL/TODOS")
  "Directory containing journal entries.
  Setting this will update auto-mode-alist using
  `(org-journal-update-auto-mode-alist)`"
  :type 'string :group 'org-journal
  :set (lambda (symbol value)
         (set-default symbol value)
         (org-journal-update-auto-mode-alist)))

(defcustom org-projects-dir (file-truename "~/Documents/000WORKFILES/PROJECTS_CURRENT")
  "Directory containing project entries.
  Setting this will update auto-mode-alist using
  `(org-journal-update-auto-mode-alist)`"
  :type 'string :group 'org-journal
  :set (lambda (symbol value)
         (set-default symbol value)
         (org-journal-update-auto-mode-alist)))
;; provide custom refile targets for todo entries
;; NOTE: This function is also used in custom function org-jump-to-refile-target.
(defun org-iz-make-refile-targets ()
"Provide custom refile targets for todo entries.
This function is also used in custom function org-jump-to-refile-target."
(setq org-refile-targets
      (append
       (mapcar (lambda (x) (cons x '(:maxlevel . 2)))
               (file-expand-wildcards (concat org-todo-dir "/*.org")))
       (mapcar (lambda (x) (cons x '(:maxlevel . 2)))
               (file-expand-wildcards (concat org-projects-dir "/*.org"))))))

;; Include all journal and todo files in agenda:
(setq org-agenda-files `(,org-journal-dir
                         ,org-todo-dir
                         ,org-projects-dir))

(defun org-journal-at-date-from-user (no-entry)
  "Creat journal entry with date from user, NO-ENTRY prefix just opens the file without creating entry."
  (interactive "P")
  (let ((time (org-read-date t t)) timestamp)
    (org-journal-new-entry no-entry time)
    (setq timestamp (format-time-string (cdr org-time-stamp-formats) time))
    ;; (if no-entry
    ;;     (insert "\n" timestamp))
    (unless no-entry
     (progn
       (insert
        "\n :PROPERTIES:\n :DATE: "
        timestamp
        " \n :END:\n")
       (previous-line 4)
       (end-of-line)))))

;; Make new-entry keyboard command available also in org-mode:
(global-set-key (kbd "C-c c j") 'org-journal-at-date-from-user)
(global-set-key (kbd "C-c c J") 'org-journal-new-entry-from-org-timestamp)
(provide 'org-journal)
;;; 033_org-journal.el ends here
