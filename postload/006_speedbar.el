(require 'deft)
(require 'sr-speedbar)  ;; loads commands required by speedbar-workfiles
(require 'org-notes)

(setq deft-use-filename-as-title t)

(speedbar-add-supported-extension ".sc")
(speedbar-add-supported-extension ".scd")
(speedbar-add-supported-extension ".js")
(speedbar-add-supported-extension ".sh")
(speedbar-add-supported-extension ".html")
(speedbar-add-supported-extension ".css")
(speedbar-add-supported-extension ".tex")

(defun deft-here (dir)
  "Change DEFT-DIRECTORY to a directory selected interactively."
  (interactive)
  ;; (setq deft-directory "~/Copy/000WORKFILES/00_META/")
  ;; (message dir)
  ;; (message "file exists? %s" (file-exists-p dir))
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
            ;; (speedbar-refresh)
            (goto-char p))))))

(defun speedbar-dired-here ()
  ;; copied from speedbar-item-delete
  "Open deft current directory."
  (interactive)
  (let ((f (speedbar-line-file)))
    (if (not f) (error "Not a file"))
    (if (speedbar-y-or-n-p (format "Dired %s? " f) t)
        (progn
          (dired-here f)
          (dframe-message "Okie dokie.")
          (let ((p (point)))
            ;; (speedbar-refresh)
            (goto-char p))))))

(defun dired-here (dir)
  "Dired dir or directory of dir if it is a file."
  (interactive)
  ;; (setq deft-directory "~/Copy/000WORKFILES/00_META/")
  ;; (message dir)
  ;; (message "file exists? %s" (file-exists-p dir))
  (setq dir
        (if (file-directory-p dir) dir (file-name-directory dir)))
  (dired dir))

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
           ;; (speedbar-refresh)
            (goto-char p))))))

(defun org-log-here (file)
  "Create org-capture entry with date in FILE."
  (when file
    (setq org-capture-templates
          (list
           (list
            "l"
            (format "log: %s" (file-name-sans-extension
                               (file-name-nondirectory file)))
            'entry (list 'file+datetree+prompt file)
            "* %?\n :PROPERTIES:\n :DATE:\t%^T\n :END:\n\n%i\n")
           (list
            "d" "diary" 'entry (list 'file+datetree+prompt
                                     (concat iz-log-dir "0_PRIVATE/DIARY.org"))
            "* %?\n :PROPERTIES:\n :DATE:\t%^T\n :END:\n\n%i\n")
           (list
            "s" "sudel" 'entry (list 'file+datetree+prompt
                                     (concat iz-log-dir "6_WEBSITES-ORG/SUDEL.org"))
            "* %?\n :PROPERTIES:\n :DATE:\t%^T\n :END:\n\n%i\n")))
    (org-capture))
  )

(defun speedbar-workfiles ()
  "Open sr-speebar on workfiles root and keep it there."
  (interactive)
  (speedbar-fixed-dir iz-log-dir))

(defun speedbar-dev ()
  "Open sr-speebar on workfiles root and keep it there."
  (interactive)
  (speedbar-fixed-dir (file-truename "~/Documents/Dev/")))

(defun speedbar-fixed-dir (dir)
  (let ((buffer (current-buffer)))
    (sr-speedbar-refresh-turn-on)
    (dired dir)
    (sr-speedbar-open)
    (speedbar-refresh)
    (sr-speedbar-refresh-turn-off)
    (switch-to-buffer buffer)))

(global-set-key (kbd "H-L") 'speedbar-log)
(global-set-key (kbd "H-s w") 'speedbar-workfiles)
(global-set-key (kbd "H-s d") 'speedbar-dev)

(defun add-speedbar-keys ()
  (local-set-key (kbd "s") 'isearch-forward)
  (local-set-key (kbd "d") 'speedbar-deft-here)
  (local-set-key (kbd "C-d") 'speedbar-dired-here)
  (local-set-key (kbd "l") 'speedbar-log-here))

(add-hook 'speedbar-mode-hook 'add-speedbar-keys)

(global-set-key (kbd "C-M-H-s") 'sr-speedbar-open)

