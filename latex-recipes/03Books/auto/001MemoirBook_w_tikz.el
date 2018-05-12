(TeX-add-style-hook
 "001MemoirBook_w_tikz"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("memoir" "9pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("mathpazo" "osf") ("euler" "mathcal" "mathbf") ("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "memoir"
    "memoir10"
    "mathpazo"
    "euler"
    "amsmath"
    "amssymb"
    "amsthm"
    "inputenc"
    "graphicx"
    "sidecap"
    "tikz"
    "siunitx")
   (TeX-add-symbols
    "swelledrule")
   (LaTeX-add-labels
    "sec:org779e596"
    "sec:org7962e5e"
    "tab:the-numbers"
    "sec:orgae8232d"
    "sec:org3171ddb"
    "sec:orgba6333c"
    "sec:org97d6de7"
    "sec:org29b73e7"
    "sec:org2bb6e37"))
 :latex)

