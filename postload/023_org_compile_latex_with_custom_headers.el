;;; org_compile_latex_with_custom_headers --- 2018-12-12 03:45:21 PM
  ;; (defun org-insert-latex-headers-from-deft ()
  ;;   "Choose latex headers from recipe list using deft, and append them to the currently edited file."
  ;;   (with-current-buffer
  ;;     ))

  ;; First load this package to initialize variables:
  (require 'ox-latex)

  ;; Use xelatex as latex compiler, thus enabling use of native fonts for greek etc.
  (setq org-latex-compiler "xelatex")

  (defvar org-current-buffer nil
    "Set by org-insert-latex-recipe to enable insertion of headers by deft.")

  (defcustom org-latex-export-path (file-truename "~/latex-exports")
    "Dirctory of path where latex exports are stored."
    :group 'org-latex-compile)

  (defcustom org-latex-bib-folder "/bibliographies/"
    "Dirctory of path where default bib files are stored."
    :group 'org-latex-compile)

  (defcustom org-latex-bib-filename "References.bib"
    "Name of default bib file."
    :group 'org-latex-compile)

  (defcustom org-latex-bib-full-path
    (concat org-latex-export-path org-latex-bib-folder org-latex-bib-filename)
    "Full path of file to default bib file."
    :group 'org-latex-compile)

  (defun org-compile-pdflatex-with-custom-headers ()
    "Export with pdflatex using custom latex headers if available."
    (interactive)
    (org-compile-latex-with-custom-headers t))

  (defun org-compile-pdflatex-subtree-with-custom-headers ()
    "Export with pdflatex using custom latex headers if available."
    (interactive)
    (org-compile-latex-with-custom-headers t t))

  (defun  org-compile-xelatex-with-custom-headers ()
    "Export with xelatex using custom latex headers if available."
    (interactive)
    (org-compile-latex-with-custom-headers))

  (defun  org-compile-xelatex-subtree-with-custom-headers ()
    "Export with xelatex using custom latex headers if available."
    (interactive)
    (org-compile-latex-with-custom-headers nil t))

  (defun org-compile-latex-with-custom-headers (&optional pdflatexp subtreep)
    "Export body, insert header+footer from sections, compile to pdf.
  If PDFLATEXP use pdflatex else use xelatex.
  Use latexmk as ORG-LATEX-PDF-PROCESS. This usually works for compiling bibtex
  and producing a bibliography section.
  If subtreep only compile the current org-subtree of the file.

  Create new filename based on user input, prompting with a file name
  constructed from the curent file and a datestamp.
  Save that file in the cache subdirectory of latex-exports.
  Insert latex header, footer, class definition sections in that file.
  Restore cursor position from the original file in the new file.
  Export file to pdf according to the options.

  This command assumes that we are already in the buffer of the file to be exported.
  "
    (let* (class header footer ;; these 3 variables are set later in the body of the let form.
                 ;; get raw latex code from current buffer
                 (latex-output (org-export-as
                                ;; backend subtreep visible-only body-only ext-plist
                                'latex  subtreep nil          t         nil
                                ))
                 (source-file (buffer-file-name))
                 (target-directory (org-get-latex-export-cache-directory))
                 (template-file (concat target-directory "/"))
                 (org-target-file
                  (concat
                   target-directory
                   "/"
                   (read-string
                    "File name base:"
                    (file-name-nondirectory (file-name-sans-extension source-file)))
                   "_"
                   (format-time-string "%y%m%d")
                   ".org"
                   ))
                 (tex-target-file
                  (concat (file-name-sans-extension org-target-file) ".tex"))
                 (pdf-file (concat
                            (file-name-sans-extension org-target-file)
                            ".pdf")))

      ;; Copy org source file to cache directory for reference
      (message "the source file is: %s\nThe target file is: %s" source-file org-target-file)
      (copy-file source-file org-target-file t)

      ;; provide default bib file if missing
      (unless
          (file-expand-wildcards (concat target-directory "/*.bib"))
        (make-symbolic-link
         org-latex-bib-full-path
         (concat target-directory "/bibliography.bib")))

      ;; get latex class, header and footer from template file

      (find-file (concat target-directory "/latex-template.org"))
      (setq class (get-class-from-section))
      (setq header (get-custom-latex-from-section "latex-header"))
      (setq footer (get-custom-latex-from-section "latex-footer"))
      (kill-buffer (current-buffer))
      ;; Insert class, header, footer to latex output and export to pdf
      (with-temp-buffer
        (unless (has-documentclass header) (insert (cadr class) "\n"))
        (insert header)
        (insert latex-output)
        (insert footer)
        (let ((coding-system-for-write 'utf-8)
              (org-latex-pdf-process
               (if pdflatexp
                   '("latexmk -shell-escape -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
                 '("latexmk -shell-escape -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
          ;;
          (write-file tex-target-file)
          (message "org-latex-default-class is:\n%s" org-latex-default-class)
          (message "org latex classes are:\n%s" org-latex-classes)
          (message "latex compile command is:\n %s" org-latex-pdf-process)
          ;; (org-latex-compile (buffer-file-name))
          (cleanup-bbl-and-compile-latex (buffer-file-name))
          (message "org-latex compile to PDF done. Opening:\n%s" (shell-quote-argument pdf-file))
          (copy-file pdf-file (concat org-latex-export-path "/"
                                      (file-name-nondirectory pdf-file)) t)
          (shell-command (concat "open " (shell-quote-argument pdf-file)))))))

  (defun has-documentclass (string)
    "Return if string contains documentclass."
    (if (string-match "documentclass" string)
        t
      nil))

  (defun test-doclass ()
      "temporary test function"
    (interactive)
    (message "Is: %s"
             (has-documentclass (buffer-substring-no-properties (point-min) (point-max)))))

  (defun cleanup-bbl-and-compile-latex (filename)
    "Remove bbl file before compiling, to ensure bibliography is compiled anew."
    (message "deleting bbl file:\n%s\n" (concat (file-name-sans-extension filename) ".bbl"))
    (delete-file (concat (file-name-sans-extension filename) ".bbl"))
    (org-latex-compile filename))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; The following functions must be rewritten.
  ;; latex-compile-file-with-xelatex
  ;; latex-compile-file-with-pdflatex
  ;; latex-compile-file-with-latexmk
  ;; Note: These functions are not used by org-compile-latex-with-custom-headers

  (defun latex-compile-file-with-xelatex ()
    "Compile tex file with xelatex and open resulting pdf file."
    (interactive)
    (latex-compile-file-with-latexmk))

  (defun latex-compile-file-with-pdflatex ()
    "Compile tex file with pdflatex and open resulting pdf file."
    (interactive)
    (latex-compile-file-with-latexmk t))

  (defun latex-compile-file-with-latexmk (&optional pdflatexp)
    "Compile tex file using latexmk.
      If PDFLATEXP then use pdflatex instead of xelatex.
      Open resulting pdf file with default macos open method."
    ;; (interactive)
    (let* ((file (buffer-file-name))
           (pdf-file (concat
                      (file-name-sans-extension file)
                      ".pdf"))
           (org-latex-pdf-process
            (if pdflatexp
                '("latexmk -shell-escape -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
              '("latexmk -shell-escape -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
      (message "latex compile command is:\n %s" org-latex-pdf-process)
      (delete-file (concat (file-name-sans-extension file) ".bbl"))
      (org-latex-compile file)
      ;; following was wrong!!!!!!!!!
      ;;    (cleanup-bbl-and-compile-latex (file))
      (message "tex->pdf done. Opening:\n%s" (shell-quote-argument pdf-file))
      (shell-command (concat "open " (shell-quote-argument pdf-file)))))

  (defcustom latex-blocks-alist
    '(
      ;; "\\documentclass{article}" has been removed!
      ("latex-header" . "\\begin{document}")
      ("latex-footer" . "\\end{document}"))
    "Alist of default latex block strings for header/footer.")

  (defun get-custom-latex-from-section (&optional section-name)
    "Provide header or footer latex code from section named SECTION-NAME.
    Get default code from LATEX-BLOCKS-ALIST."
    (setq section-name (or section-name "latex-header"))
    (let ((code (or
                 (cdr (assoc section-name latex-blocks-alist))
                 "")))
      (org-map-entries
       (lambda ()
         (let ((element (cadr (org-element-at-point))))
           (when (string= section-name (plist-get element :title))
             (setq code (get-contents-or-babel element)))
           )))
      code))

  (defun get-class-from-section (&optional section-name)
    "Get latex class from section named SECTION-NAME.
    If class was found, add it to org-latex-classes.
    Return class."
    (setq section-name (or section-name "latex-class"))
    (let ((code "") class)
      (org-map-entries
       (lambda ()
         (let ((element (cadr (org-element-at-point))))
           (when (string= section-name (plist-get element :title))
             (setq code (get-contents-or-babel element))
             (setq class (eval (car (read-from-string code))))
             ))))
      (if
          class
          (add-to-list 'org-latex-classes class)
        (setq class '("article" "\\documentclass[10pt]{article}")))
      (message "I AM SETTING CLASS TO THIS:\n%s" class)
      class))

  (defun get-latex-section (&optional section-name)
    "Get entire section with name matching SECTION-NAME."
    (setq section-name (or section-name "latex-header"))
    (let ((code (or
                 (cdr (assoc section-name latex-blocks-alist))
                 "")))
      (org-map-entries
       (lambda ()
         (let ((element (cadr (org-element-at-point))))
           (when (string= section-name (plist-get element :title))
             (org-copy-subtree)
             (setq code (current-kill 0)))
           )))
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
      (when src-block-beginning
        (setq result (substring
                      result
                      src-content-beginning
                      (or
                       ;; if no end of block was found, use end of section contents
                       (string-match "^#\\\+END_SRC" result)
                       (string-width result)))))
      result))

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;; use deft to select and insert custom headers for latex export

  ;; Browse recipes using deft.  Deft setup:
  (prelude-load-require-packages '(deft))
  (eval-after-load 'deft
    '(progn
       (define-key deft-mode-map (kbd "C-i") 'deft-select-latex-headers)
       (setq deft-current-sort-method 'title)))

  (setq deft-use-filename-as-title t)

  ;; include org, sc, el, txt, tex files in deft search
  (setq deft-extensions '( "org" "txt"))

  ;; use latex-recipes as deft directory
  (setq deft-directory (concat (directory-file-name
                                (file-name-directory
                                 (directory-file-name
                                  (file-name-directory (directory-file-name load-file-name)))))
                               "/latex-recipes/"))

  (setq deft-use-filter-string-for-filename t) ;; create file names from user input - not timestamps

  ;; search directories recursively in deft
  (setq deft-recursive t)

  ;; Functions for getting headers from deft
  (defun deft-select-latex-headers ()
    "Copy folder of selected latex header files to cache, and construct template file.
  Empty latex export cache subdirectory.
  Copy current directory contents to latex export cache subdirectory."
    (interactive)
    (let* ((cache-dir (org-get-latex-export-cache-directory))
          (source-file (deft-filename-at-point))
          (source-directory (file-name-directory source-file)))
      (when (directory-name-p cache-dir)
        (delete-directory cache-dir t t))
      (copy-directory source-directory cache-dir t t t)
      (copy-file source-file (concat cache-dir "/latex-template.org") t)
      (with-temp-buffer
        (insert source-file)
        (write-file (concat cache-dir "/template-file-path.txt")))))

  (defun org-get-latex-export-cache-directory ()
    "Return path of latex-export-cache subdirectory."
    (concat org-latex-export-path "/cache"))

  (defun org-post-current-latex-export-template ()
    "Post file name of latex-template from latex-exports cache subdirectory."
    (interactive)
    (let* ((template-file (org-get-latex-template-file-path))
           (template (if (file-exists-p template-file)
                         (with-temp-buffer
                           (insert-file-contents template-file)
                           (buffer-string))
                       nil)))
      (if template
          (message "The template file is: %sIts folder is: %s"
                   (file-name-nondirectory template)
                   (file-name-directory template))
        (message "no template file found at %" template-file))))

  (defun org-get-latex-template-file-path ()
    "Return path of latex-tempalte-file name from leatex-exports cache subdirectory."
    (concat (org-get-latex-export-cache-directory) "/template-file-path.txt"))
(provide 'org_compile_latex_with_custom_headers)
;;; 023_org_compile_latex_with_custom_headers.el ends here
