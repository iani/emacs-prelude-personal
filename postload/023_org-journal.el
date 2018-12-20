;;; org-journal --- 2018-12-20 06:11:41 AM
  ;;; Commentary:
  ;;; use org-journal for capture globally into files named by date number.
  ;;; https://github.com/bastibe/org-journal.
  ;;; Set agenda folders and files.
  ;;; Define custom agenda commands.

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
  ;; (setq diary-file (concat (file-name-directory org-journal-dir) "diary"))
  (setq diary-file (file-truename "~/BitTorrent Sync/000WORKFILES/PERSONAL/diary"))
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

  ;; Define custom agenda commands for some useful tag searches
  ;; NOTE: These are the keys used by default agenda dispatch menu:
  ;; a t T m M e s S / < > # ! C
  ;;
  ;; a     Call `org-agenda-list' to display the agenda for current day or week.
  ;; t     Call `org-todo-list' to display the global todo list.
  ;; T     Call `org-todo-list' to display the global todo list, select only
  ;;             entries with a specific TODO keyword (the user gets a prompt).
  ;; m     Call `org-tags-view' to display headlines with tags matching a condition  (the user is prompted for the condition).
  ;; M     Like `m', but select only TODO entries, no ordinary headlines.
  ;; e     Export views to associated files.
  ;; s     Search entries for keywords.
  ;; S     Search entries for keywords, only with TODO keywords.
  ;; /     Multi occur across all agenda files and also files listed in `org-agenda-text-search-extra-files'.
  ;; <     Restrict agenda commands to buffer, subtree, or region. Press several times to get the desired effect.
  ;; >     Remove a previous restriction.
  ;; #     List \"stuck\" projects.
  ;; !     Configure what \"stuck\" means.
  ;; C     Configure custom agenda commands.

  ;;       Any own keys should be other than the above!

  (setq org-agenda-custom-commands
        '(("A" tags "+avarts")
          ("E" tags "+eastndc")
          ("p" tags "+phd")
          ("w" tags "+weinstein")
          ("h" tags "+health")
          ("f" tags "+finance")
          ("c" tags "+correspondence")))

  ;; Make new-entry keyboard command available also in org-mode:
  (global-set-key (kbd "C-c c j") 'org-journal-at-date-from-user)
  (global-set-key (kbd "C-c c J") 'org-journal-new-entry-from-org-timestamp)
(provide 'org-journal)
;;; 023_org-journal.el ends here
