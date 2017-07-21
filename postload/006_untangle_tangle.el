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
    (mapc (lambda (fname)
            (message fname))
          files)
    ;; (erase-buffer)
    
    )
)

(defun org-el-tangle-sections ()
  "Export each sections' emacs-lisp block to a separate file."
  (interactive)
  )

(format-time-string "%y%m%d")

(provide '006_untangle_tangle)
;;; 006_untangle_tangle ends here
