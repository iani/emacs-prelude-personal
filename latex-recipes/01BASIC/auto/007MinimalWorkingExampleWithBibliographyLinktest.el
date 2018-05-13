(TeX-add-style-hook
 "007MinimalWorkingExampleWithBibliographyLinktest"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "biblatex")
   (LaTeX-add-labels
    "sec:orgd222635"
    "sec:org218f05a"
    "sec:org1643479")
   (LaTeX-add-bibliographies
    "bibliography-LINKED"))
 :latex)

