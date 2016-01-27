(require 'deft)

(setq deft-use-filename-as-title t)

(defun deft-here (dir)
  "Change DEFT-DIRECTORY to a directory selected interactively."
  (interactive)
  ;; (setq deft-directory "~/Copy/000WORKFILES/00_META/")
  (message dir)
  (message "file exists? %s" (file-exists-p dir))
  (setq deft-directory
        (if (file-directory-p dir) dir (file-name-directory dir)))
  (switch-to-buffer deft-buffer)
  (deft-mode))

(defun speedbar-deft-here ()
  ;; copied from speedbar-item-delete
  "Open deft current directory."
  (interactive)
  (let ((f (speedbar-line-file)))
    (if (not f) (error "Not a file"))
    (if (speedbar-y-or-n-p (format "Open Deft on %s? " f) t)
        (progn
          (deft-here f)
          (dframe-message "Okie dokie.")
          (let ((p (point)))
            (speedbar-refresh)
            (goto-char p))))))

(defun speedbar-log-here ()
  ;; copied from speedbar-item-delete
  "Create org-log entry on selected file."
  (interactive)
  (let ((f (speedbar-line-file)))
    (if (not f) (error "Not a file"))
    (if (speedbar-y-or-n-p (format "Create log entry on %s? " f) t)
        (progn
          (org-log-here f)
          (dframe-message "Okie dokie.")
          (let ((p (point)))
            (speedbar-refresh)
            (goto-char p))))))

(defun org-log-here (FILE)
  "Create org-log entry in FILE.")

(defun speedbar-agenda-here (PATH)
  ;; copied from speedbar-item-delete
  "Open org-agenda on directory or file at PATH."
  (interactive)
  (let ((f (speedbar-line-file)))
    (if (not f) (error "Not a file"))
    (if (speedbar-y-or-n-p (format "Open agenda on %s? " f) t)
        (progn
          (org-agenda-here f)
          (dframe-message "Okie dokie.")
          (let ((p (point)))
            (speedbar-refresh)
            (goto-char p))))))

(defun org-agenda-here ()
  "Open org-agenda on selected directory or file."
  )

(defun add-speedbar-keys ()
  (local-set-key (kbd "d") 'speedbar-deft-here)
  (local-set-key (kbd "a") 'speedbar-agenda-here)
  (local-set-key (kbd "l") 'speedbar-log-here))

(add-hook 'speedbar-mode-hook 'add-speedbar-keys)

(global-set-key (kbd "C-M-H-s") 'sr-speedbar-open)

