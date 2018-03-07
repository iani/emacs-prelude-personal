;;; org_mode_latex_export --- 2018-03-07 08:52:46 PM
   ;;; NOTE: See notes in master file about upgrading to org-mode version 9.
   ;;; This is needed to use xelatex.

   ;; First load this package to initialize variables:
   (require 'ox-latex)

   ;; Use xelatex as latex compiler, thus enabling use of native fonts for greek etc.
   (setq org-latex-compiler "xelatex")

   ;; Add some latex classes.  Testing stage.  Keepin this simple for now.
   (add-to-list 'org-latex-classes '("letter" "\\documentclass[11pt]{scrlttr2}"))
   ;; See example letter in folder ../latex-examples

   ;; use fontspec package to enable system fonts in xelatex
   (add-to-list 'org-latex-packages-alist '("" "fontspec"))
   ;; allow more flexible spaces between words for justified text
   (add-to-list 'org-latex-packages-alist "\\sloppy")

   ;; Browse recipes using deft
   (prelude-load-require-packages '(deft))
   (eval-after-load 'deft
     '(progn
        (define-key deft-mode-map (kbd "C-i") 'deft-insert-file-other-buffer)))

   (defun deft-insert-file-other-buffer ()
     "Copy contents of file selected in deft window to kill ring."
     (interactive)
     (let ((filename (deft-filename-at-point)))
       (unless filename
         (goto-char (line-beginning-position))
         (setq filename (deft-filename-at-point)))
       (when filename
         (message "test %s" filename)
         (other-window 1)
         (goto-char (point-min))
         (insert-file-contents filename))))

   (setq deft-use-filename-as-title t)

   ;; include org, sc, el, txt, tex files in deft search
   (setq deft-extensions '( "org" "sc" "scd" "el" "txt" "tex"))

   ;; use latex-recipes as deft directory
   (setq deft-directory (concat (directory-file-name
                                 (file-name-directory
                                  (directory-file-name
                                   (file-name-directory (directory-file-name load-file-name)))))
                                "/latex-recipes/"))

   (setq deft-use-filter-string-for-filename t) ;; create file names from user input - not timestamps

   ;; search directories recursively in deft
   (setq deft-recursive t)
(provide 'org_mode_latex_export)
;;; 023_org_mode_latex_export.el ends here
