;;; org_calfw --- 2018-02-28 04:14:12 PM
  ;;; Commentary:
  ;;; use calfw package to display agenda in calendar-grid format
  ;;; Provide commands for generation of entries on current date on calendar grid

  ;;; Code:
;; (require 'calfw-org)
;; (require 'calfw-cal)

(prelude-load-require-packages '(calfw calfw-org calfw-cal))

(setq calendar-christian-all-holidays-flag t)

(setq org-capture-use-agenda-date t)

(setq cfw:org-overwrite-default-keybinding t)

(defun org-calfw-here (&optional arg)
  "Open calfw on the file of the present buffer."
  (interactive "P")
  (when (and (buffer-file-name) (eq major-mode 'org-mode))
    (if arg
        (setq org-agenda-files (list (buffer-file-name)))
      (add-to-list 'org-agenda-files (buffer-file-name))))
  ;; (org-log-here (buffer-file-name) t)
  (cfw:open-org-calendar))

;; (defun cfw:org-capture (prefix)
;;   "Overwrite original to run own cfw:org-capture-at-date instead."
;;   (interactive "P")
;;   (cfw:org-journal-at-date prefix))

(defun cfw:org-journal-at-date-from-cursor (prefix)
  "Run org-journal-new-entry with ORG-OVERRIDING-DEFAULT-TIME from cursor."
  (interactive "P")
  (with-current-buffer  (get-buffer-create cfw:calendar-buffer-name)
    (let* ((pos (cfw:cursor-to-nearest-date))
           (org-overriding-default-time
            (encode-time 0 0 7
                         (calendar-extract-day pos)
                         (calendar-extract-month pos)
                         (calendar-extract-year pos))))
      (org-journal-new-entry prefix org-overriding-default-time)
      (unless prefix
        (org-insert-time-stamp org-overriding-default-time t)
        (backward-word)
        (backward-word)
        (paredit-forward-kill-word)
        (paredit-forward-kill-word)))))

(defun cfw:org-journal-entry-for-now (prefix)
  "Run org-journal-new-entry with date+time timestamp from current time."
  (interactive "P")
  (with-current-buffer  (get-buffer-create cfw:calendar-buffer-name)
    (let* ((pos (cfw:cursor-to-nearest-date))
           (org-overriding-default-time (apply 'encode-time (decode-time))
                                        ;; (encode-time 0 0 7
                                        ;;              (calendar-extract-day pos)
                                        ;;              (calendar-extract-month pos)
                                        ;;              (calendar-extract-year pos))
                                        ))
      (org-journal-new-entry prefix org-overriding-default-time)
      (org-insert-time-stamp org-overriding-default-time t))))

(defun org-jump-to-refile-target ()
  "Make org-refile with prefix available as command.
  Also, always update refile targets before running org-refile.
  This ensures that files changed / created recently will be taken into account."
  (interactive)
  (org-iz-make-refile-targets)
  (org-refile '(4)))

(global-set-key (kbd "M-C-g") 'org-jump-to-refile-target)
(global-set-key (kbd "C-c c c") 'org-calfw-here)
(global-set-key (kbd "C-c C J") 'cfw:org-journal-entry-for-now)
;; journal entry for Now (current date and time at time of command)
(define-key
  cfw:calendar-mode-map "N" 'cfw:org-journal-entry-for-now)
;; journal entry for Here (date at cursor on calfw buffer)
(define-key
  cfw:calendar-mode-map "H" 'cfw:org-journal-at-date-from-cursor)


;; (define-key
;;   cfw:calendar-mode-map "C" 'cfw:org-journal-entry-for-now)
;; (define-key
;;   cfw:calendar-mode-map "c" 'cfw:org-journal-at-date-from-cursor)

(provide '018_calfw)
  ;;; 018_calfw.el ends here
(provide 'org_calfw)
;;; 023_org_calfw.el ends here
