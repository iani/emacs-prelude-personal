(TeX-add-style-hook
 "Dissertate"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("book" "12pt" "twoside" "letterpaper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("titlesec" "medium" "sf" "sc") ("quotchap" "palatino") ("natbib" "super" "comma" "numbers") ("geometry" "textwidth=6.3in" "textheight=8.75in" "left=1in" "letterpaper") ("appendix" "titletoc") ("units" "tight" "nice") ("tocloft" "titles") ("caption" "labelfont={bf,sf,footnotesize,singlespacing}" "								textfont={sf,footnotesize,singlespacing}" "								justification={justified,RaggedRight}" "								singlelinecheck=false" "								margin=0pt" "								figurewithin=chapter" "								tablewithin=chapter")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "book"
    "bk12"
    "xcolor"
    "hyperref"
    "titlesec"
    "titling"
    "quotchap"
    "kvoptions"
    "graphicx"
    "amssymb"
    "lettrine"
    "natbib"
    "geometry"
    "pdfpages"
    "fancyhdr"
    "appendix"
    "scalefnt"
    "setspace"
    "booktabs"
    "units"
    "verbatim"
    "url"
    "tocloft"
    "ragged2e"
    "amsmath"
    "mathspec"
    "caption")
   (TeX-add-symbols
    '("newthought" 1)
    "degreeyear"
    "degreemonth"
    "degree"
    "advisor"
    "department"
    "field"
    "university"
    "universitycity"
    "universitystate"
    "programname"
    "pdOneName"
    "pdOneSchool"
    "pdOneYear"
    "pdTwoName"
    "pdTwoSchool"
    "pdTwoYear")
   (LaTeX-add-lengths
    "mybibindent"))
 :latex)

