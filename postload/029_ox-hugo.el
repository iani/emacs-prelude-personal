;;; ox-hugo --- 2018-12-04 09:34:32 AM
  ;; Functions for ox-hugo.  (11 Aug 2018 11:36)
  (defun ox-hugo-prepare-and-export ()
    "Call org-export-dispatch.
  Obsolete!"
    (interactive)
    ;; (let ((weight 0))
    ;;   (org-map-entries 'org--set-weight))
    (call-interactively 'org-export-dispatch))

  ;; (defun org--set-weight ()
  ;;   "Calculate and set EXPORT_HUGO_WEIGHT property for this entry."
  ;;   (org-set-property "EXPORT_HUGO_WEIGHT" (format "%d" weight))
  ;;   (setq weight (+ 1 weight)))
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun ox-hugo-clear-contents ()
    "Delete contents of HUGO_BASE_DIR."
    (interactive)
    (let* ((org-use-property-inheritance (org-hugo--selective-property-inheritance))
           (info (org-combine-plists
                  (org-export--get-export-attributes
                   'hugo nil nil
                   ;; subtreep visible-only
                   )
                  (org-export--get-buffer-attributes)
                  (org-export-get-environment 'hugo nil)))
           (pub-dir (org-hugo--get-pub-dir info)))
      (when (y-or-n-p (format "Delete contents of %s?" pub-dir))
        (delete-directory pub-dir t)
        (message "%s deleted!" pub-dir))))

  (defun ox-hugo-copy-root-dir ()
    "Copy hugo root directory to kill ring as shell-escaped string.
  Use: Paste the copied string in a shell terminal to go to the root dir,
  and then run hugo-server or hugo or other related commands."
    (interactive)
    (let* ((org-use-property-inheritance (org-hugo--selective-property-inheritance))
           (info (org-combine-plists
                  (org-export--get-export-attributes
                   'hugo nil nil
                   ;; subtreep visible-only
                   )
                  (org-export--get-buffer-attributes)
                  (org-export-get-environment 'hugo nil)))
           (pub-dir (org-hugo--get-pub-dir info)))
      (kill-new
       (shell-quote-argument (file-name-directory (directory-file-name pub-dir))))
      (message "Copied %s"
               (shell-quote-argument (file-name-directory (directory-file-name pub-dir))))))
(provide 'ox-hugo)
;;; 029_ox-hugo.el ends here
