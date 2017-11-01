;; copied from old repository.  Needs review
;; 10 May 2016 18:20

;;; Load latex package for org-mode exports
(require 'ox-latex)

;;; Use xelatex instead of pdflatex, for support of multilingual fonts (Greek etc.)
;; Note: Use package polyglossia to customize dates and other details.
(setq org-latex-pdf-process
      (list "xelatex -interaction nonstopmode -output-directory %o %f"
            "xelatex -interaction nonstopmode -output-directory %o %f"
            "xelatex -interaction nonstopmode -output-directory %o %f"))

;; This is kept as reference. XeLaTeX covers all european/greek/asian needs.
;; It is the original setting for working with pdflatex:
;; (setq org-latex-pdf-process
;;  ("pdflatex -interaction nonstopmode -output-directory %o %f"
;;   "pdflatex -interaction nonstopmode -output-directory %o %f"
;;   "pdflatex -interaction nonstopmode -output-directory %o %f"))

;;; Add beamer to available latex classes, for slide-presentaton format
(add-to-list 'org-latex-classes
             '("beamer"
               "\\documentclass\[presentation\]\{beamer\}"
               ("\\section\{%s\}" . "\\section*\{%s\}")
               ("\\subsection\{%s\}" . "\\subsection*\{%s\}")
               ("\\subsubsection\{%s\}" . "\\subsubsection*\{%s\}")))

;;; Add memoir class (experimental)
(add-to-list 'org-latex-classes
             '("memoir"
               "\\documentclass[12pt,a4paper,article]{memoir}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; Reconfigure memoir to make a book (or report) from a org subtree
(add-to-list 'org-latex-classes
             '("section-to-book"
               "\\documentclass{memoir}"
               ("\\chapter{%s}" . "\\chapter*{%s}") ;; actually: BOOK TITLE!
               ("\\section{%s}" . "\\section*{%s}") ;; actually: Chapter!
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

;; Letter
(add-to-list 'org-latex-classes
             '("letter"
               "\\documentclass{letter}"
               ;; Should not use subsections at all!:
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))

(add-to-list 'org-latex-classes
             '("newlfm-letter"
               "\\documentclass[11pt,letter,dateno,sigleft]{newlfm}"
               ;; Should not use subsections at all!:
               ("\\chapter{%s}" . "\\chapter*{%s}")
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")))
