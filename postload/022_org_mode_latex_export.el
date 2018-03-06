;;; org_mode_latex_export --- 2018-03-06 07:48:22 AM
   ;;; NOTE: See notes in master file about upgrading to org-mode version 9.
   ;;; This is needed to use xelatex.

   ;; Use xelatex as latex compiler, thus enabling use of native fonts for greek etc.
   (setq org-latex-compiler "xelatex")

   ;; use fontspec package to enable system fonts in xelatex
   ()
(provide 'org_mode_latex_export)
;;; 022_org_mode_latex_export.el ends here
