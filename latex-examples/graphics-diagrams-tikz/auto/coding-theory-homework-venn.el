(TeX-add-style-hook
 "coding-theory-homework-venn"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "a4paper")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "inner=1.5cm" "outer=1.5cm" "top=2.5cm" "bottom=2.5cm") ("xcolor" "rgb") ("hyperref" "colorlinks=true" "urlcolor=blue" "linkcolor=blue" "citecolor=blue") ("todonotes" "colorinlistoftodos") ("babel" "francais")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "geometry"
    "setspace"
    "xcolor"
    "verbatim"
    "amsgen"
    "amsmath"
    "amstext"
    "amsbsy"
    "amsopn"
    "tikz"
    "amssymb"
    "tkz-linknodes"
    "fancyhdr"
    "hyperref"
    "todonotes"
    "rotating"
    "babel"
    "booktabs")
   (TeX-add-symbols
    '("homework" 6)
    '("ra" 1)
    "bbF"
    "bbX"
    "bI"
    "bX"
    "bY"
    "bepsilon"
    "balpha"
    "bbeta")
   (LaTeX-add-labels
    "equ1.1")
   (LaTeX-add-environments
    "thm"
    "prop"
    "lem"
    "cor"
    "defn"
    "rem"))
 :latex)

