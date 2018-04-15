(TeX-add-style-hook
 "007MinimalWorkingExampleWithBibliographyGreekJapanese"
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
    "sec:orgf811eee"
    "sec:org97b953f")
   (LaTeX-add-bibliographies
    "bibliography-ml"))
 :latex)

