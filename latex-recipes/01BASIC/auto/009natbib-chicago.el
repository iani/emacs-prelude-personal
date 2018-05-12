(TeX-add-style-hook
 "009natbib-chicago"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "natbib")
   (LaTeX-add-bibliographies
    "bibliography-ml.bib"))
 :latex)

