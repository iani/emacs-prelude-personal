(TeX-add-style-hook
 "001MemoirBook_w_tikz"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("memoir" "9pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("mathpazo" "osf") ("euler" "mathcal" "mathbf") ("inputenc" "utf8")))
   (TeX-run-style-hooks
    "latex2e"
    "memoir"
    "memoir10"
    "mathpazo"
    "euler"
    "amsmath"
    "amssymb"
    "amsthm"
    "inputenc"
    "graphicx"
    "sidecap"
    "tikz"
    "siunitx")
   (TeX-add-symbols
    "swelledrule")
   (LaTeX-add-labels
    "sec:orge719e46"
    "sec:org6007440"
    "tab:the-numbers"
    "sec:orga5c8848"
    "sec:org3201d74"
    "sec:org157c746"
    "sec:org640612e"
    "sec:org1561400"
    "sec:orga9e6ad6"))
 :latex)

