(TeX-add-style-hook
 "006MinimalWorkingExampleWithBibliographyGreek"
 (lambda ()
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "fontspec"
    "biblatex")
   (LaTeX-add-labels
    "sec:org3210f2a")
   (LaTeX-add-bibliographies
    "bibliography"))
 :latex)

