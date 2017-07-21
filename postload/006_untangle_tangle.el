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
       (files (file-expand-wildcards (concat directory "*.el"))))
    ;; (message (concat (file-truename directory) filename))
    (find-file filename)
    (erase-buffer)
    (mapc 'org-el-insert-1-file
          files)
    
    )
  )

(defun org-el-insert-1-file (fname)
  "insert file FNAME into the master org file.
Create org header and SRC block from data in FNAME file."
  (message fname)
  (save-excursion
    (let*
        ((fname-base (file-name-base fname))
         (header (concat
                  "\n* "
                  fname-base))
         header-found)
      (find-file fname)
      (goto-char (point-min))
      (setq header-found
            (search-forward
             fname-base
             (line-end-position 1)
             t
             1))
      (cond
       (header-found
        (message "a header WAS found")
        (message "the line containing the header is:")
        (message (buffer-substring (line-beginning-position)
                                   (line-end-position 1))))
       (t
        (message "a header was NOTTTTTTTTT found")
        (message "the first line is:")
        (message (buffer-substring (line-beginning-position)
                                   (line-end-position 1)))
        ))
      ))
  )

( org-el-tangle-sections ()
                         "Export each sections' emacs-lisp block to a separate file."
                         (interactive)
                         )

(format-time-string "%y%m%d")

(provide '006_untangle_tangle)
;;; 006_untangle_tangle ends here
