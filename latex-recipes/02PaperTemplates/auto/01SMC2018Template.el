(TeX-add-style-hook
 "01SMC2018Template"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "english") ("biblatex" "backend=biber") ("hypcap" "figure" "table") ("hyperref" "dvips" "bookmarksnumbered" "pdfstartview=XYZ") ("epsfig" "dvips") ("graphicx" "pdftex" "dvips")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
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
    "sec:org68dfe75"
    "sec:orgc35701f"
    "sec:org86a4c91"
    "sec:org5aa2464"
    "fig:example"
    "sec:orga43f1ca"
    "sec:org57742ae"
    "sec:orge0debc2"
    "sec:org2b23c0f")
   (LaTeX-add-bibliographies
    "smc2018bib"))
 :latex)

