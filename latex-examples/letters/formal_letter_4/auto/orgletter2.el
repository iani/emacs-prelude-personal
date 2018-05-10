(TeX-add-style-hook
 "orgletter2"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("letter" "11pt" "a4paper")))
   (TeX-run-style-hooks
    "latex2e"
    "structure"
    "letter"
    "letter11"))
 :latex)

