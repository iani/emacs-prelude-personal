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
    "sec:orgc40254e"
    "sec:org9fd2490"
    "sec:orge673d40")
   (LaTeX-add-bibliographies
    "bibliography-LINKED"))
 :latex)

