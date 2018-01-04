;;; tiny_menu --- 2018-01-04 10:39:33 AM
  ;;; Commentary:

  ;; test code for using tiny-menu
  ;; from: https://blog.aaronbieber.com/2016/07/31/org-navigation-revisited.html

  ;;; Code:

  (prelude-load-require-package 'tiny-menu)

  (defun air--org-global-custom-ids ()
    "Find custom ID fields in all org agenda files."
    (let ((files (org-agenda-files))
          file
          air-all-org-custom-ids)
      (while (setq file (pop files))
        (with-current-buffer (org-get-agenda-file-buffer file)
          (save-excursion
            (save-restriction
              (widen)
              (goto-char (point-min))
              (while (re-search-forward "^[ \t]*:CUSTOM_ID:[ \t]+\\(\\S-+\\)[ \t]*$"
                                        nil t)
                (add-to-list 'air-all-org-custom-ids
                             `(,(match-string-no-properties 1)
                               ,(concat file ":" (number-to-string (line-number-at-pos))))))))))
      air-all-org-custom-ids))

  (defun air-org-goto-custom-id ()
    "Go to the location of a custom ID, selected interactively."
    (interactive)
    (let* ((all-custom-ids (air--org-global-custom-ids))
           (custom-id (completing-read
                       "Custom ID: "
                       all-custom-ids)))
      (when custom-id
        (let* ((val (cadr (assoc custom-id all-custom-ids)))
               (id-parts (split-string val ":"))
               (file (car id-parts))
               (line (string-to-int (cadr id-parts))))
          (pop-to-buffer (org-get-agenda-file-buffer file))
          (goto-char (point-min))
          (forward-line line)
          (org-reveal)
          (org-up-element)))))

  ;; The helm menu does not update when changing the org-refile-targets variable like this.
  ;; Switch to icicle mode as a workaround.
  (defun air-refile-goto-current-buffer ()
    "Set refile targets to current buffer and call org-refile with 1 u prefix."
    (interactive)
    (let ((org-refile-targets `((,buffer-file-name :maxlevel . 10))))
      (icy-mode 1)
      (org-refile '(4))
      (icy-mode -1)))

  (setq tiny-menu-items
        '(("org-things"   ("Things"
                           ((?t "Tag"     org-tags-view)
                            (?i "ID"      air-org-goto-custom-id)
                            (?k "Keyword" org-search-view)
                            (?l "Refile Goto Local" air-refile-goto-current-buffer)
                            )))
          ("org-links"    ("Links"
                           ((?c "Capture"   org-store-link)
                            (?l "Insert"    org-insert-link)
                            (?i "Custom ID" air-org-insert-custom-id-link))))))

  (global-set-key (kbd "C-H-M-t") 'tiny-menu)
(provide 'tiny_menu)
;;; 028_tiny_menu.el ends here
