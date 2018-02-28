;;; org-mode:_Use_uppercase_UUIDs_in_Linux_for_consistency_with_MacOS_when_syncing_with_rslsync --- 2018-02-28 04:14:12 PM
(defun org-id-get (&optional pom create prefix)
  "Get the ID property of the entry at point-or-marker POM.

This is a modified version that returns the ID using uppercase letters,
for consistency with MacOS when syncing attachment folders over rslsync.

If POM is nil, refer to the entry at point.
If the entry does not have an ID, the function returns nil.
However, when CREATE is non nil, create an ID if none is present already.
PREFIX will be passed through to `org-id-new'.
In any case, the ID of the entry is returned."
  (org-with-point-at pom
    (let ((id (org-entry-get nil "ID")))
      (cond
       ((and id (stringp id) (string-match "\\S-" id))
        id)
       (create
        (setq id (org-id-new prefix))
        (org-entry-put pom "ID" id)
        (org-id-add-location id (buffer-file-name (buffer-base-buffer)))
        (upcase id))))))
(provide 'org-mode:_Use_uppercase_UUIDs_in_Linux_for_consistency_with_MacOS_when_syncing_with_rslsync)
;;; 021_org-mode:_Use_uppercase_UUIDs_in_Linux_for_consistency_with_MacOS_when_syncing_with_rslsync.el ends here
