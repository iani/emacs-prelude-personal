(TeX-add-style-hook
 "005MinimalWorkingExampleWithBibliography"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "biblatex")
   (LaTeX-add-labels
    "sec:orgdd22496"
    "sec:org59a6ee0")
   (LaTeX-add-bibliographies
    "bibliography"))
 :latex)

