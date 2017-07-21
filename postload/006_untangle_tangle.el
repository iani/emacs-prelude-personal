;;; 006_untangle_tangle --- import multiple el files to org and v.v.

;;; Commentary:
;;; org-el-untangle:
;;; import muliple el files from one folder into one org mode file.
;;; org-el-tangle-sections
;;; export each sections' emacs-lisp block to a separate file.

;;; Code:

(defun org-el-untangle (directory)
  "Import muliple el files from one folder into one org mode file."
  (interactive "D")
  (let
      ((filename (concat "MASTER-FILE-" (format-time-string "%y%m%d") ".org"))
       (files (file-expand-wildcards (concat directory "*.el")))
       (target-buffer))
    ;; (message (concat (file-truename directory) filename))
    (find-file filename)
    (erase-buffer)
    (setq target-buffer (current-buffer))
    (mapc 'org-el-insert-1-file files)))

(defun org-el-insert-1-file (fname)
  "Insert file FNAME into the master org file.
Create org header and SRC block from data in FNAME file."
  (message fname)
  (save-excursion
    (let*
        ((fname-base (file-name-base fname))
         (header (concat
                  "\n* "
                  (replace-regexp-in-string "_" " " (substring fname-base 3 nil))
                  "\n"))
         found body-start body-end body)
      (find-file fname)
      (goto-char (point-min))
      (setq found
            (search-forward
             fname-base
             (line-end-position 1)
             t
             1))
      (cond
       (found
        (message "a header WAS found")
        (message "the line containing the header is:")
        (message (buffer-substring (line-beginning-position)
                                   (line-end-position 1)))
        (forward-line 1)
        (setq body-start (point)))
       (t
        (message "a header was NOTTTTTTTTT found")
        (message "the first line is:")
        (message (buffer-substring (line-beginning-position)
                                   (line-end-position 1)))
        (setq body-start (point-min))
        ))
      (setq found
            (search-forward
             (format "provide '%s" fname-base)
             nil
             t
             1))
      (cond
       (found
        (message "a FOOTER WAS found")
        (message "the line containing the FOOTER is:")
        (message (buffer-substring (line-beginning-position)
                                   (line-end-position 1)))
        (setq body-end (line-beginning-position)))
       (t
        (message "a FOOTER was NOTTTTTTTTT found")
        (message "the first line is:")
        (message (buffer-substring (line-beginning-position)
                                   (line-end-position 1)))
        (setq body-end (point-max))
        ))
      (setq body (buffer-substring body-start body-end))
      (kill-buffer (current-buffer))
      (with-current-buffer target-buffer
        (insert (replace-regexp-in-string "  " " " header))
        (insert "\n#+BEGIN_SRC emacs-lisp\n")
        (insert body)
        (insert "#+END_SRC\n\n"))
      ))
  )

(defun org-el-tangle-sections ()
  "Export each sections' emacs-lisp block to a separate file."
  (interactive)
  )

(format-time-string "%y%m%d")

(provide '006_untangle_tangle)
;;; 006_untangle_tangle ends here
