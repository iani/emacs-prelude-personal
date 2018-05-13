(TeX-add-style-hook
 "008MinimalWorkingExampleBibliographyChicagoNatbib"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("biblatex-chicago" "authordate" "autocite=inline" "backend=biber" "natbib")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "xeCJK"
    "biblatex-chicago")
   (LaTeX-add-labels
    "sec:orga29c965"
    "sec:org819804f"
    "sec:orgcdb5f9b"
    "sec:orgce7e87d"
    "sec:orgb93f506")
   (LaTeX-add-bibliographies
    "bibliography-ml.bib"))
 :latex)

