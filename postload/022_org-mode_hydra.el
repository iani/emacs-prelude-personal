;;; org-mode_hydra --- 2018-12-20 07:26:18 AM
  (defhydra hydra-org ( :color red :columns 3)
    "org-mode hydra"
    ("n" outline-next-visible-heading "next heading")
    ("p" outline-previous-visible-heading "prev heading")
    ;; ("C-p" outline-previous-visible-heading "prev heading")
    ("N" org-forward-heading-same-level "next heading at same level")
    ("P" org-backward-heading-same-level "prev heading at same level")
    ("C-p" org-prev-show-properties "prev show properties")
    ("c" org-cycle "cycle")
    ("u" outline-up-heading "up heading")
    ("i" icicle-imenu "icicle imenu" :exit t)
    ("I" imenu-anywhere "imenu" :exit t)
    ("g" air-goto-section "icicles goto" :exit t)
    ("f" ox-hugo-set-filename "hugo set filename")
    ("F" ox-hugo-set-index-filename "hugo set index filename")
    ("s" ox-hugo-set-section "hugo set section")
    ;; section* does not work reliably with ox-hugo
    ;; ("S" ox-hugo-set-section* "hugo set section*")
    ("c" ox-hugo-clear-contents "clear hugo content dir")
    ;; has been incorporated as advice to org-export-dispatch function:
    ;; ("w" ox-hugo-set-weights "hugo set weights")
    ("r" ox-hugo-copy-root-dir "copy root dir")
    ("q" nil "quit" :color blue))

  (defun org-prev-show-properties ()
    "Go to previous heading and open subtree."
    (interactive)
    (outline-previous-heading)
    (org-show-subtree))

  (defun ox-hugo-set-filename (&optional file-name)
    "Set property EXPORT_FILE_NAME."
    (interactive "MFile name: ")
    (org-set-property "EXPORT_FILE_NAME" file-name)
    (message "EXPORT_FILE_NAME was set to %" file-name))

  (defun ox-hugo-set-index-filename ()
    "Set property EXPORT_FILE_NAME to _index."
    (interactive)
    (org-set-property "EXPORT_FILE_NAME" "_index")
    (message "EXPORT_FILE_NAME was set to _index"))

  (defun ox-hugo-set-section (&optional section-name)
    "Set property EXPORT-NAME."
    (interactive "MSection name: ")
    (org-set-property "EXPORT_HUGO_SECTION" section-name)
    (message "EXPORT_HUGO_SECTION was set to %" section-name))

  ;; section* does not work reliably.
  ;; (defun ox-hugo-set-section* (&optional section-name)
  ;;   "Set property EXPORT_SECTION*"
  ;;   (interactive "MSection name: ")
  ;;   (org-set-property "EXPORT_HUGO_SECTION*" section-name)
  ;;   (message "EXPORT_HUGO_SECTION* was set to %" section-name))
(provide 'org-mode_hydra)
;;; 022_org-mode_hydra.el ends here
