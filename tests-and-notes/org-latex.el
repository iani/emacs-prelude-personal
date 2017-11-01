;; 12 May 2016 12:21 support for org-latex export
;; Customize the header of the latex file by choosing from
;; an existing file containing the header.

;; this is based on the following two functions - to be re-done:

(defun org-latex-export-with-file-template (&optional as-latex-buffer-p subtree-p)
  (let* (;; backup to restore original latex-classes after this operation:
         (org-latex-classes-backup org-latex-classes)
         (chosen-template-path (org-query-latex-template-path subtree-p))
         (this-buffers-latex-class
          (plist-get (org-export-get-environment 'latex subtree-p nil) :latex-class))
         latex-header
         (latex-sections
          (or ;; TODO: Add (org-latex-get-local-section-settings subtree-p) here.
           (cddr (assoc this-buffers-latex-class org-latex-classes))
           latex-section-templates)))
    (when chosen-template-path
      (setq org-latex-last-chosen-file-name chosen-template-path)
      (setq latex-header
            (with-temp-buffer
              (insert-file-contents chosen-template-path)
              (concat
               "[NO-DEFAULT-PACKAGES]\n"
               "[NO-EXTRA]\n"
               "\n"
               (buffer-string))))
      ;; Create custom org-latex-classes to use this template:
      (setq org-latex-classes
            (list
             (append
              (list this-buffers-latex-class latex-header)
              latex-sections)))

      (if as-latex-buffer-p
          (org-latex-export-as-latex nil subtree-p nil nil)
        (let ((pdf-path (org-export-output-file-name ".pdf" subtree-p))
              (tex-path (org-export-output-file-name ".tex" subtree-p))
              (attach-path (org-file-or-subtree-attachment-dir subtree-p t)))
          (org-latex-export-to-pdf nil subtree-p nil nil)
          (copy-file pdf-path
                     (concat
                      attach-path
                      (file-name-nondirectory pdf-path))
                     t)
          (copy-file tex-path
                     (concat
                      attach-path
                      (file-name-nondirectory tex-path))
                     t)
          (copy-file chosen-template-path
                     (concat
                      attach-path
                      (file-name-nondirectory chosen-template-path))
                     t)
          (shell-command (concat
                          "open -a /Applications/Preview.app "
                          "\""
                          attach-path
                          (file-name-nondirectory pdf-path)
                          "\""))))
      ;; restore original latex classes:
      (setq org-latex-classes org-latex-classes-backup))))

(defun org-query-latex-template-path (&optional subtree-p)
  "Get and set latex template path from menu of paths found in default folder.
Include:
1. list of template files found in latex-templates-path,
2. last used template org-latex-last-chosen-file-name,
3. template last chosen for export of this file or subtree,
4. and local copy of template used for export of this file or subtree.

Also:
1. Copy chosen template to attachment directory.
2. Store paths of chosen template and its copy as property.
"
  (let*
      ((paths (file-expand-wildcards (concat latex-templates-path "/*.tex")))
       (names-and-paths
        (mapcar
         (lambda (x)
           (cons (file-name-sans-extension (file-name-nondirectory x)) x))
         paths))
       (local-template-path (org-get-option-or-property "LATEX_TEMPLATE" subtree-p))
       (local-template-copy-path
        (org-get-option-or-property "LATEX_TEMPLATE_COPY" subtree-p))
       menu chosen-filename new-template-copy-path)
    (if org-latex-last-chosen-file-name
        (setq names-and-paths
              (append
               names-and-paths
               (list (cons (concat
                            "[Last chosen template:] "
                            (file-name-sans-extension
                             (file-name-nondirectory org-latex-last-chosen-file-name)))
                           org-latex-last-chosen-file-name)))))
    (if local-template-path
        (setq names-and-paths
              (append
               names-and-paths
               (list (cons (concat
                            "[Local template:] "
                            (file-name-sans-extension
                             (file-name-nondirectory local-template-path)))
                           org-latex-last-chosen-file-name)))))
    (if local-template-copy-path
        (setq names-and-paths
              (append
               names-and-paths
               (list (cons (concat
                            "[Copy of local template:] "
                            (file-name-sans-extension
                             (file-name-nondirectory local-template-copy-path)))
                           org-latex-last-chosen-file-name)))))
    (setq menu (grizzl-make-index (mapcar 'car names-and-paths)))
    (setq chosen-filename
          (cdr (assoc (grizzl-completing-read "Choose latex template: " menu)
                      names-and-paths)))
    (when chosen-filename
      (setq org-latex-last-chosen-file-name chosen-filename)
      (org-put-option-or-property "LATEX_TEMPLATE" chosen-filename subtree-p)
      (setq new-template-copy-path
            (concat
             (org-file-or-subtree-attachment-dir subtree-p t)
             (file-name-nondirectory chosen-filename)))
      (org-put-option-or-property "LATEX_TEMPLATE_COPY"
                                  new-template-copy-path subtree-p)
      (copy-file chosen-filename new-template-copy-path t))
    chosen-filename))
