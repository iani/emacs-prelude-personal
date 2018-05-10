(TeX-add-style-hook
 "01SMC2018Template.org[*Org Src 01SMC2018Template"
 (lambda ()
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10")
   (TeX-add-symbols
    "papertitle"
    "firstauthor"))
 :latex)

