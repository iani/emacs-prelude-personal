(TeX-add-style-hook
 "try"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("preview" "active" "tightpage")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "tikz"
    "verbatim"
    "preview"))
 :latex)

