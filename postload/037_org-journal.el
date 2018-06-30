;;; org-journal --- 2018-06-30 10:14:50 AM
  ;;; Commentary:
  ;;; use org-journal for capture globally.
  ;;; https://github.com/bastibe/org-journal

  ;;; Code:

  (prelude-load-require-package 'org-journal)

  ;; Create files with .org ending to automatically enable org-mode when loading them:
  (setq org-journal-file-format "%Y%m%d.org")

  ;; allow input of dates before 1970
  (setq org-read-date-force-compatible-dates nil)

  (defun org-journal-new-entry-from-org-timestamp ()
    "Like org-journal-new-entry except read time interactively using org-read-date."
    (interactive)
    (org-journal-new-entry nil (apply 'encode-time (org-parse-time-string (org-read-date t t)))))

  ;; Use own path for journal dir:
  ;; (setq org-journal-dir (file-truename "~/Documents/000WORKFILES/PERSONAL/journal"))
  ;; On 27 Jun 2018 16:01 get stack overflow with above. changing now to this:
  (setq org-journal-dir (file-truename "~/journal"))

  ;; Use own path for diary dir:
  (setq org-agenda-diary-file 'diary-file)
  (setq diary-file (concat (file-name-directory org-journal-dir) "diary"))
  (setq org-agenda-include-diary t)

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

  (defun org-journal-at-date-from-calendar (no-entry)
    "Creat journal entry on calendar cursor date, if NO-ENTRY do not create entry."
    (interactive "P")
    (let* ((monthdayyear (calendar-cursor-to-date))
           (month (car monthdayyear))
           (day (cadr monthdayyear))
           (year (caddr monthdayyear))
           (time (encode-time 0 0 7 day month year))
           (timestamp (format-time-string (cdr org-time-stamp-formats) time)))
      (message "Creating entry at: %s" timestamp)
      (org-journal-new-entry no-entry time)
      ;; (setq timestamp (format-time-string (cdr org-time-stamp-formats) time))
      ;; (if no-entry
      ;;     (insert "\n" timestamp))
      (unless no-entry
        (progn
          (insert
           "\n :PROPERTIES:\n :DATE: "
           timestamp
           " \n :END:\n")
          (previous-line 2)
          (end-of-line)
          (backward-char 4)
          (org-time-stamp t)))))

  (defun my/bindkey-recompile ()
    "Bind <F5> to `recompile'."
    (local-set-key (kbd "J") 'org-journal-at-date-from-calendar))

  (add-hook 'calendar-mode-hook 'my/bindkey-recompile)

  ;; Make new-entry keyboard command available also in org-mode:
  (global-set-key (kbd "C-c c j") 'org-journal-at-date-from-user)
  (global-set-key (kbd "C-c c J") 'org-journal-new-entry-from-org-timestamp)
(provide 'org-journal)
;;; 037_org-journal.el ends here
