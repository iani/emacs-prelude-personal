;;; ox-hugo --- 2018-12-05 01:36:09 AM
  ;; Functions for ox-hugo.  (11 Aug 2018 11:36)
  (defun ox-hugo-set-weights ()
    "Set correct hugo weights, then Call org-export-dispatch.

  Note: the auto-weight option of ox-hugo sets wrong weights, which result
  in subsubsections to be always at the bottom of a subsection, and not
  inside the subsection to which they belong. Therefore, the present renumbering is
  necessary if editing a site that has nested subsections inside subsections"
    (interactive)
    (let ((weight 0))
      (org-map-entries 'ox-hugo--set-weight))
    ;; The ox-hugo options disappear the second time after calling this:
    ;; (org-export-dispatch)
    (message "Weights for hugo export have been set."))

  (defun ox-hugo--set-weight ()
    "Set EXPORT_HUGO_WEIGHT property for this entry.
  Note: the auto-weight option of ox-hugo sets wrong weights, which result
  in subsubsections to be always at the bottom of a subsection, and not
  inside the subsection to which they belong. Therefore, the present renumbering is
  necessary if editing a site that has nested subsections inside subsections."
     (org-set-property "EXPORT_HUGO_WEIGHT" (format "%d" weight))
     (setq weight (+ 1 weight)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; try adding ox-hugo-set-weights as advice to export

  ;; (defun my-message (&optional ARG PRED)
  ;;   (message "Hello!"))

  (advice-add 'org-export-dispatch :before 'ox-hugo-set-weights)

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
