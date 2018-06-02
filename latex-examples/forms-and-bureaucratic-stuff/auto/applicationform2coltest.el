(TeX-add-style-hook
 "applicationform2coltest"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("geometry" "a4paper" "margin=2cm") ("hyperref" "colorlinks")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "geometry"
    "lipsum"
    "multicol"
    "hyperref"))
 :latex)

