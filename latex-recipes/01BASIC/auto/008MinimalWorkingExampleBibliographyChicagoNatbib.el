(TeX-add-style-hook
 "008MinimalWorkingExampleBibliographyChicagoNatbib"
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
    "sec:org97697fd"
    "sec:orgc81c908"
    "sec:org3aeb118"
    "sec:org585dd35"
    "sec:org42aeacd")
   (LaTeX-add-bibliographies
    "bibliography-ml.bib"))
 :latex)

