(TeX-add-style-hook
 "004MimimalWorkingExampleJapaneseGreek"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("article" "10pt")))
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-braces-local "path")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "url")
   (add-to-list 'LaTeX-verbatim-macros-with-delims-local "path")
   (TeX-run-style-hooks
    "latex2e"
    "article"
    "art10"
    "url"
    "xeCJK")
   (LaTeX-add-labels
    "sec:org66c9dc9"
    "sec:org2eaf86e"
    "sec:orgc17385a"
    "sec:org1ea5832"
    "sec:orgfe64a49"))
 :latex)

