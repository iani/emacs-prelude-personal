(TeX-add-style-hook
 "008MinimalWorkingExampleBibliographyChicago"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("biblatex-chicago" "authordate" "autocite=inline" "backend=biber")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "biblatex-chicago")
   (LaTeX-add-labels
    "sec:org1eebb7e"
    "sec:orgef54282"
    "sec:org65b5405"
    "sec:org3b47046"
    "sec:orgf0b3bb4")
   (LaTeX-add-bibliographies
    "bibliography-ml.bib"))
 :latex)

