(TeX-add-style-hook
 "xelatex-polytonic-test"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "fontspec")
   (TeX-add-symbols
    '("test" 1)))
 :latex)

