(TeX-add-style-hook
 "01SMC2018Template"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "english") ("biblatex" "backend=biber") ("hypcap" "figure" "table") ("hyperref" "dvips" "bookmarksnumbered" "pdfstartview=XYZ") ("epsfig" "dvips") ("graphicx" "pdftex" "dvips")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "smc2018"
    "times"
    "ifpdf"
    "babel"
    "biblatex"
    "graphicx"
    "hypcap"
    "hyperref"
    "epsfig")
   (TeX-add-symbols
    "papertitle"
    "firstauthor"
    "secondauthor"
    "thirdauthor")
   (LaTeX-add-labels
    "sec:orgf4b7b65"
    "sec:org9d6a80e"
    "sec:org548836b"
    "sec:org51c2ae1"
    "fig:example"
    "sec:org39c4a6d"
    "sec:orgd811d42"
    "sec:org8f9bba5"
    "sec:org1524f24")
   (LaTeX-add-bibliographies
    "smc2018bib"))
 :latex)

