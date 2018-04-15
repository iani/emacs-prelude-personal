(TeX-add-style-hook
 "007MinimalWorkingExampleWithBibliographyLinktest"
 (lambda ()
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "biblatex")
   (LaTeX-add-labels
    "sec:orgf69752d"
    "sec:org5439f43"
    "sec:org44dae73")
   (LaTeX-add-bibliographies
    "bibliography-LINKED"))
 :latex)

