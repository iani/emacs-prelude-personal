(TeX-add-style-hook
 "006MinimalWorkinExampleMultilingualBibliography"
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
    "sec:orgb70bf8b"
    "sec:org09449c9"
    "sec:org3eff5f5")
   (LaTeX-add-bibliographies
    "bibliography-ml"))
 :latex)

