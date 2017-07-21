;;; ox-twbs --- Publish with bootstrap

;;; Commentary:
;; Provides dynamic menu in right column.

;;; Code:

(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/org-bs/"
         :publishing-directory "~/public_html-bs/"
         :publishing-function org-twbs-publish-to-html
         :with-sub-superscript nil
         )))


(defun org-publish-twbs ()
  "Publish using ox-twbs.
This version saves the buffer into the default base-directory for publishing,
and then deletes the published file and buffer after publishing.
This means, any org-file can be published, independently from wher it is stored.
No need to define a different base-directory for the publish-project-alist."
  (interactive)
  (save-buffer)
  (message
   (file-truename (concat
                   "~/org-bs/"
                   (file-name-nondirectory (buffer-file-name)))))
  (write-file
   (file-truename (concat
                   "~/org-bs/"
                   (file-name-nondirectory (buffer-file-name)))))
  (save-excursion (org-publish-current-file))
  (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
         (proj-plist (cdr proj))
         (rel (file-relative-name buffer-file-name
                                  (plist-get proj-plist :base-directory)))
         (dest (plist-get proj-plist :publishing-directory)))
    (delete-file (buffer-file-name)) ;; keep the publishing directory empty
    (kill-buffer (current-buffer))
    (browse-url (concat "file://"
                        (file-name-as-directory (expand-file-name dest))
                        (file-name-sans-extension rel)
                        ".html"))))

;; Original version
;; (defun my-org-publish-buffer ()
;;   "Publish using ox-twbs."
;;   (interactive)
;;   (save-buffer)
;;   (write-file (file-truename (concat
;;                               "~/org-bs/"
;;                               (file-name-nondirectory (buffer-file-name)))))
;;   (save-excursion (org-publish-current-file))
;;   (let* ((proj (org-publish-get-project-from-filename buffer-file-name))
;;          (proj-plist (cdr proj))
;;          (rel (file-relative-name buffer-file-name
;;                                   (plist-get proj-plist :base-directory)))
;;          (dest (plist-get proj-plist :publishing-directory)))
;;     (browse-url (concat "file://"
;;                         (file-name-as-directory (expand-file-name dest))
;;                         (file-name-sans-extension rel)
;;                         ".html"))))

(global-set-key (kbd "s-\\") 'org-publish-twbs)

(provide '033-ox-twbs)
;;; 033-ox-twbs.el ends here
