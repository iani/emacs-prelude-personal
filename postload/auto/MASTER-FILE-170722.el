(TeX-add-style-hook
 "MASTER-FILE-170722"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "11pt")))
   (TeX-add-to-alist 'LaTeX-provided-package-options
                     '(("ulem" "normalem")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "nolinkurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperbaseurl")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperimage")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "hyperref")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art11"
    "graphicx"
    "grffile"
    "longtable"
    "wrapfig"
    "rotating"
    "ulem"
    "amsmath"
    "textcomp"
    "amssymb"
    "capt-of"
    "hyperref")
   (LaTeX-add-labels
    "sec:org8751c3a"
    "sec:org887d244"
    "sec:org111a566"
    "sec:org0c7471a"
    "sec:orgd6a8681"
    "sec:orge483e92"
    "sec:orgbf3f289"
    "sec:org7d140c9"
    "sec:orgd80f180"
    "sec:org221672f"
    "sec:org6c69c1c"
    "sec:org7138813"
    "sec:org180d0c9"
    "sec:org1ae87ba"
    "sec:org83b0d1e"
    "sec:org99a3e05"
    "sec:orge50d9f8"
    "sec:orgc1b81d6"
    "sec:org5904403"
    "sec:orgeafa384"
    "sec:orgad48529"
    "sec:org4f06dae"
    "sec:org88d6118"
    "sec:org4222f96"
    "sec:orge7a7ba1"
    "sec:orgcdde828"
    "sec:orgeb5afe3"
    "sec:orgc56b1b5"
    "sec:org233ae15"
    "sec:org2a95887"
    "sec:org7df3bad"
    "sec:orga9cd462"
    "sec:org8cae27c"
    "sec:org06945b9"
    "sec:org2cc30fe"
    "sec:org3157454"
    "sec:org77a1020"
    "sec:org9363876"))
 :latex)

