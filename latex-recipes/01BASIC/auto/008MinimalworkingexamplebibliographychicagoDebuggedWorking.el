(TeX-add-style-hook
 "008MinimalworkingexamplebibliographychicagoDebuggedWorking"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("biblatex-chicago" "authordate" "autocite=inline" "backend=biber" "natbib")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "biblatex-chicago")
   (LaTeX-add-labels
    "sec:orga772e78"
    "sec:org6b47ad2"
    "sec:org4435e41")
   (LaTeX-add-bibliographies
    "bibliography-ml.bib"))
 :latex)

