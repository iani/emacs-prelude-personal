(TeX-add-style-hook
 "006MinimalWorkinExampleMultilingualBibliography"
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
    "xeCJK"
    "biblatex")
   (LaTeX-add-labels
    "sec:org2b813dd"
    "sec:org34e0f2f"
    "sec:org80b8e8b")
   (LaTeX-add-bibliographies
    "bibliography-ml"))
 :latex)

