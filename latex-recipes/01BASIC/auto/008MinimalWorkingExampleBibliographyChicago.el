(TeX-add-style-hook
 "008MinimalWorkingExampleBibliographyChicago"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("biblatex-chicago" "authordate" "autocite=inline" "backend=biber")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "biblatex-chicago")
   (LaTeX-add-labels
    "sec:orgc70572b"
    "sec:orgaf78503"
    "sec:org4f13eaf"
    "sec:orgfc03ec6"
    "sec:org44fe1d4")
   (LaTeX-add-bibliographies
    "bibliography-ml.bib"))
 :latex)

