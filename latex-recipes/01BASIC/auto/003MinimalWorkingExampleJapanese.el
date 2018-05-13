(TeX-add-style-hook
 "003MinimalWorkingExampleJapanese"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "fontspec"))
 :latex)

