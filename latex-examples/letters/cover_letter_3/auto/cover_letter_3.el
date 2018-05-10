(TeX-add-style-hook
 "cover_letter_3"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("newlfm" "10pt" "stdletter" "dateno" "sigleft")))
   (TeX-run-style-hooks
    "latex2e"
    "newlfm"
    "newlfm10"
    "charter")
   (LaTeX-add-saveboxes
    "Luiuc"))
 :latex)

