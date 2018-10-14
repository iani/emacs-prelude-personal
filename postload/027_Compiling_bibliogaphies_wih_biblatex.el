;;; Compiling_bibliogaphies_wih_biblatex --- 2018-10-14 10:40:32 AM
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
      and producing a bibliography section."

    (let* ((document-class (get-class-from-section "latex-class"))
           (org-latex-default-class (car document-class))
           (output (org-export-as
                    ;; backend subtreep visible-only body-only ext-plist
                    'latex  subtreep nil          t         nil
                    ))
           (source-directory-path
            (replace-regexp-in-string
             "/$" "" (file-name-directory (buffer-file-name))))
           (source-directory-name
            (file-name-nondirectory source-directory-path))
           (target-directory-path
            (concat
             org-latex-export-path
             "/"
             source-directory-name))
           (file (concat
                  target-directory-path
                  "/"
                  (read-string
                   "File name base:"
                   (file-name-nondirectory (file-name-sans-extension (buffer-file-name))))
                  "_"
                  (format-time-string "%y%m%d")
                  ".tex"))
           (pdf-file (concat
                      (file-name-sans-extension file)
                      ".pdf"))
           (header (get-custom-latex-from-section "latex-header"))
           (footer (get-custom-latex-from-section "latex-footer"))
           )

      (message source-directory-path)
      (message target-directory-path)

      (message "the default source bib path is: \n%s"
               (concat source-directory-path "/bibliography.bib")
               )
      (unless
          (file-expand-wildcards (concat source-directory-path "/*.bib"))
        (make-symbolic-link
         org-latex-bib-full-path
         (concat source-directory-path "/bibliography.bib")))

       (copy-directory
        source-directory-path
        target-directory-path
        nil ;; do not keep time
        t   ;; create parents if needed
        t   ;; copy contents only - do not replace directory)
        )

      (with-temp-buffer
        (insert (cadr document-class) "\n")
        (insert header)
        (insert output)
        (insert footer)
        (let ((coding-system-for-write 'utf-8)
              (org-latex-pdf-process
               (if pdflatexp
                   '("latexmk -shell-escape -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
                 '("latexmk -shell-escape -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
          (write-file file)
          (message "org-latex-default-class is:\n%s" org-latex-default-class)
          (message "org latex classes are:\n%s" org-latex-classes)
          (message "latex compile command is:\n %s" org-latex-pdf-process)
          ;; (org-latex-compile (buffer-file-name))
          (cleanup-bbl-and-compile-latex (buffer-file-name))
          (message "org-latex compile to PDF done. Opening:\n%s" (shell-quote-argument pdf-file))
          (shell-command (concat "open " (shell-quote-argument pdf-file)))))))

  (defun cleanup-bbl-and-compile-latex (filename)
    "Remove bbl file before compiling, to ensure bibliography is compiled anew."
    (message "deleting bbl file:\n%s\n" (concat (file-name-sans-extension filename) ".bbl"))
    (delete-file (concat (file-name-sans-extension filename) ".bbl"))
    (org-latex-compile file))

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

  (defun org-deft-latex-recipes ()
    "Select latex recipe with deft and insert its headers to current buffer."
    (interactive)
    (setq org-current-buffer (current-buffer))
    (deft))

  ;; Browse recipes using deft.  Deft setup:
  (prelude-load-require-packages '(deft))
  (eval-after-load 'deft
    '(progn
       (define-key deft-mode-map (kbd "C-i") 'deft-insert-latex-headers)
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
  (defun deft-insert-latex-headers ()
    "Get latex headers from current file and append them to ORG-CURRENT-BUFFER.
    ORG-CURRENT-BUFFER is set from org-latex-insert-headers-recipe."
    (interactive)
    (if (null org-current-buffer)
        (message "there is no current buffer to insert headers.")
      (let ((filename (deft-filename-at-point))
            (headers "") (header "") (footer "") header-file-buffer)
        (find-file filename)
        (setq header-file-buffer (current-buffer))
        (setq header (get-latex-section "latex-header"))
        (setq footer (get-latex-section "latex-footer"))
        (switch-to-buffer org-current-buffer)
        (kill-buffer header-file-buffer)
        (save-excursion
          (goto-char (point-max))
          (insert header "\n" footer)
          (push-mark))
        (message
         "Type C-x C-x to see headers from %s"
         (file-name-nondirectory filename)))))

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
(provide 'Compiling_bibliogaphies_wih_biblatex)
;;; 027_Compiling_bibliogaphies_wih_biblatex.el ends here
