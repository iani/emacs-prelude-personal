(TeX-add-style-hook
 "smc2018template"
 (lambda ()
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
    "sec:introduction"
    "sec:page_size"
    "sec:typeset_text"
    "subsec:body"
    "eq:BP"
    "tab:example"
    "fig:example")
   (LaTeX-add-bibliographies
    "smc2018bib"))
 :latex)

