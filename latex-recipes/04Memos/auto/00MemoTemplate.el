(TeX-add-style-hook
 "00MemoTemplate"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("texMemo" "a4paper" "12pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("babel" "english" "main=portuguese") ("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "texMemo"
    "texMemo12"
    "babel"
    "inputenc"
    "iflang"
    "ifthen"
    "parskip"))
 :latex)

