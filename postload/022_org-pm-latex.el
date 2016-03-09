(defvar org-pm-latex-template-root (expand-file-name "~/latex-templates/")
  "Folder storing latex templates")

(unless (file-exists-p org-pm-latex-template-root)
  (make-directory org-pm-latex-template-root t))

(eval-after-load 'org
  '(progn
     (define-key org-mode-map (kbd "C-c C-x l") 'org-pm-export-latex)))


