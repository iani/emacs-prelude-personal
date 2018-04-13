;;; org_compile_latex_with_custom_headers --- 2018-04-13 10:13:29 PM
  (defun org-compile-latex-with-custom-headers (&optional pdflatexp)
    "Export body, insert header+footer from sections, compile to pdf.
  If PDFLATEXP use pdflatex else use xelatex.
  Use latexmk as ORG-LATEX-PDF-PROCESS. This usually works for compiling bibtex
  and producing a bibliography section."
    (interactive "P")
    (let ((output (org-export-as
                   'latex nil nil t nil
                   ;; backend subtreep visible-only body-only ext-plist
                   ))
          (file (concat
                 (file-name-sans-extension (buffer-file-name))
                 ".tex"))
          (pdf-file (concat
                     (file-name-sans-extension (buffer-file-name))
                     ".pdf"))
          (header (get-custom-latex-from-section "latex-header"))
          (footer (get-custom-latex-from-section "latex-footer")))
      (with-temp-buffer
        (insert header)
        (insert output)
        (insert footer)
        (let ((coding-system-for-write 'utf-8)
              (org-latex-pdf-process
               (if pdflatexp
                   '("latexmk -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
                 '("latexmk -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
          (write-file file)
          (org-latex-compile (buffer-file-name))
          (shell-command (concat "open " pdf-file))))))

  (defun org-latex-compile-interactive ()
    "Interactive version of org-latex-compile. Uses current buffer as default"
    (interactive)
    (org-latex-compile (buffer-file-name)))

  (defcustom latex-blocks-alist
    '(
      ("latex-header" . "\\documentclass{article}
  \\begin{document}")
      ("latex-footer" . "\\end{document}"))
    "Alist of default latex block strings for header/footer.")

  ;; (cdr (assoc "latex-header" latex-blocks-alist))
  ;; (cdr (assoc "latex-footer" latex-blocks-alist))

  (defun get-custom-latex-from-section (&optional section-name)
    "Provide header or footer latex code from section matching SECTION-NAME.
  Get default code from LATEX-BLOCKS-ALIST."
    ;; (interactive)
    (setq section-name (or section-name "latex-header"))
    ;; (message "section-name is %s" section-name)
    (let ((code (or
                 (cdr (assoc section-name latex-blocks-alist))
                 "")))
      ;; (message "code is %s" code)
      (org-map-entries
       (lambda ()
         (let ((element (cadr (org-element-at-point))))
           (when (string= section-name (plist-get element :title))
             (setq code (get-contents-or-babel element)))
           )))
      ;; (message "testing. code is:\n%s" code)
      code))

  (defun get-contents-or-babel (element)
    "Get contents of section or babel block as string from ELEMENT."
    (let* ((result (buffer-substring-no-properties
                    (plist-get element :contents-begin)
                    (plist-get element :contents-end)))
           (src-block-beginning
            (string-match "^#\\\+BEGIN_SRC +[a-z-]+" result))
           (src-content-beginning
            (match-end 0)))
      ;; (message "the contents I will search are:\n%s" result)
      ;; (message "src-block-beginning %s src-content-beginning %s"
      ;;          src-block-beginning
      ;;          src-content-beginning)
      (when src-block-beginning
        (setq result (substring
                      result
                      src-content-beginning
                      (or
                       ;; if no end of block was found, use end of section contents
                       (string-match "^#\\\+END_SRC" result)
                       (string-width result)))))
      result))
(provide 'org_compile_latex_with_custom_headers)
;;; 024_org_compile_latex_with_custom_headers.el ends here
