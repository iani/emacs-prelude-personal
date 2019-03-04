(TeX-add-style-hook
 "LAC19Paper1812_190216"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "twoside" "letterpaper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("inputenc" "utf8") ("fontenc" "T1") ("babel" "english") ("hypcap" "figure" "table") ("epsfig" "dvips") ("graphicx" "pdftex" "dvips") ("hyperref" "dvips" "colorlinks=false" "bookmarksnumbered" "pdfstartview=XYZ")))
   (add-to-list 'LaTeX-verbatim-environments-local "lstlisting")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "lstinline")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "lstinline")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "LAC-19"
    "amsmath"
    "amssymb"
    "amsfonts"
    "amsthm"
    "euscript"
    "inputenc"
    "fontenc"
    "ifpdf"
    "color"
    "listings"
    "babel"
    "caption"
    "subfig"
    "times"
    "graphicx"
    "hypcap"
    "epsfig"
    "hyperref")
   (TeX-add-symbols
    "papertitle"
    "paperauthorA"
    "paperauthorB"
    "paperauthorC"
    "paperauthorD")
   (LaTeX-add-labels
    "sec:org76a9d46"
    "sec:orgb2a2e0a"
    "sec:orgf4cec25"
    "sec:org377c371"
    "sec:org2b045cc"
    "sec:orgdca8b90"
    "sec:org60d17a9"
    "sec:orgf7f4eda"
    "sec:org25b2b15"
    "sec:org3710b4a"
    "orgbb00958"
    "eventstream"
    "sec:org1bae379"
    "orgd2fe318"
    "io"
    "sec:orgecc9af8"
    "sec:org97e7be8"
    "orgb202bef"
    "playeroperator"
    "playergui"
    "sec:orgf1b6813"
    "sec:orgb868267"
    "sec:org3b34936"
    "sec:orga711ab0"
    "sec:org57b943d"
    "sec:org26918fc"
    "snippetlist"
    "graingui"
    "sec:org54949cc"
    "formschema"
    "formschemagui"
    "sec:orgd49f516")
   (LaTeX-add-color-definecolors
    "mygrey"))
 :latex)

