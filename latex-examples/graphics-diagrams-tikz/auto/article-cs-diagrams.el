(TeX-add-style-hook
 "article-cs-diagrams"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "a4paper" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("fontenc" "T1") ("inputenc" "utf8x") ("babel" "french")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art12"
    "fontenc"
    "inputenc"
    "babel"
    "fullpage"
    "tikz-uml"))
 :latex)

