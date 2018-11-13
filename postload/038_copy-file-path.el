;;; copy-file-path --- 2018-11-13 12:50:31 PM
  (defun crux-copy-file-path (&optional dir-path-only-p)
  "Copy the current buffer's file path or dired path to `kill-ring'.
  Result is full path.
  If `universal-argument' is called first, copy only the dir path.
  URL `http://ergoemacs.org/emacs/emacs_copy_file_path.html'
  Version 2015-12-02"
    (interactive "P")
    (let ((ξfpath
           (if (equal major-mode 'dired-mode)
               (expand-file-name default-directory)
             (if (null (buffer-file-name))
                 (user-error "Current buffer is not associated with a file.")
               (buffer-file-name)))))
      (kill-new
       (if (null dir-path-only-p)
           (progn
             (message "File path copied: 「%s」" ξfpath)
             ξfpath
             )
         (progn
           (message "Directory path copied: 「%s」" (file-name-directory ξfpath))
           (file-name-directory ξfpath))))))

  (global-set-key (kbd "C-c P") 'crux-copy-file-path)
(provide 'copy-file-path)
;;; 038_copy-file-path.el ends here
