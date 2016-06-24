(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/org-bs/"
         :publishing-directory "~/public_html-bs/"
         :publishing-function org-twbs-publish-to-html
         :with-sub-superscript nil
         )))

(defun my-org-publish-buffer ()
  (interactive)
  (save-buffer)
  (save-excursion (org-publish-current-file))
  (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
         (proj-plist (cdr proj))
         (rel (file-relative-name buffer-file-name
                                  (plist-get proj-plist :base-directory)))
         (dest (plist-get proj-plist :publishing-directory)))
    (browse-url (concat "file://"
                        (file-name-as-directory (expand-file-name dest))
                        (file-name-sans-extension rel)
                        ".html"))))

(global-set-key (kbd "s-\\") 'my-org-publish-buffer)

(provide '033-ox-twbs)
;;; 033-ox-twbs.el ends here
