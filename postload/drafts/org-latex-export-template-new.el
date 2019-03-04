;;; org-latex-export-template --- Simplify export to latex/pdf from org mode

;;; Commentary:

;; New version.  28 Feb 2019 14:18 ff

;; Compile org mode buffer to pdf using these options:
;; 1. xelatex or pdflatex
;; 2. whole buffer or current subtree only

;; Instead of defining the latex header using org-mode/emacs,
;; output the latex body only, and then import it in a framework template
;; specified by the user.
;; Use latex \import{file} directive inside template file to import the body
;; exported by org-mode.
;; To specify the template file that you want to use in an org-mode-file or section,
;; store it as file or subtree property "LATEX_EXPORT_TEMPLATE."

;; A. How the template path is stored in the org file:

;; A1: If the export option current subtree is chosen, then:
;; A1.1 Get the path stored in property "LATEX_EXPORT_TEMPLATE" in the current subtree
;; A1.2 If the path is not found in property of A1.1, then get the global property "LATEX_EXPORT_TEMPLATE".
;; A1.3 If none of the above 1 and 2 are found, then use the default path: ~/latex-exports/templates/00BASIC/framework.tex
;; A1.4 If the path given is a directory, then append to it "framework.tex".  Else use the path as-is.

;; B. How the template is used for compiling.

;; Note: By framework file we mean the file specified by the user, which will provide
;; the necessary header and footer.
;; By <template> we mean the path of the directory which contains the framework file.
;; The framework file must contain an input statement: \input{body.tex}.
;; Org exports the chosen subtree or the entire buffer as body only, into the file:
;; <template>body.tex.
;; Then it compiles the file <template>/framework.tex
;; It uses as output a name chosen interactively from the user, and always adds a date stamp to it.
;; After compiling, it copies the resulting pdf file into the folder ~/latex-exports/exports/

;; (defun org-insert-latex-headers-from-deft ()
;;   "Choose latex headers from recipe list using deft, and append them to the currently edited file."
;;   (with-current-buffer
;;     ))

;;; Code:

;; First load this package to initialize variables:
(require 'ox-latex)

;; Use xelatex as latex compiler, thus enabling use of native fonts for greek etc.
(setq org-latex-compiler "xelatex")

(defcustom org-latex-export-path (file-truename "~/latex-exports")
  "Directory where latex exports are stored."
  :group 'org-latex-compile)

(defcustom org-latex-bib-folder "/bibliographies/"
  "Directory where default bib files are stored.
This is a subdirectory of ORG-LATEX-EXPORT-PATH."
  :group 'org-latex-compile)

(defcustom org-latex-bib-filename "References.bib"
  "Name of default bib file."
  :group 'org-latex-compile)

(defun org-latex-bib-full-path ()
  "Calculate full path of file to default bib file.
Concatenate org-latex-export-path with org-latex-bib-folder and org-latex-bib-filename."
  (concat org-latex-export-path org-latex-bib-folder org-latex-bib-filename))

(defun org-latex-default-template-path ()
  "Calculate full path of file to default template framework file.
Concatenate org-latex-export-path with default path.
Issue error if latex-export folder has not been installed."
  (let ((template-path (concat org-latex-export-path
                               "/templates/00BasicGreek/framework.tex")))
    (if (file-exists-p template-path)
        template-path
      (error "You must install latex-templates in your home folder to use this."))))

(defun org-latex-body-path (framework-path)
  "Calculate full path of file to body file from FRAMEWORK-PATH."
  (concat (file-name-directory framework-path) "body.tex"))

(defun test ()
  "Temporary test function for debugging this package."
  (interactive)
  (message "found: %s"
           (save-excursion
             (org-with-wide-buffer
              (goto-char (point-min))
              (let* ((property-value (org-latex-default-template-path))
                     (property-name "LATEX_HEADER_PATH")
                     (here (re-search-forward
                            (concat "^"
                                    (regexp-quote (concat "#+" property-name ":")))
                            ;; property-name
                            ;; (concat "^"
                            ;;         (regexp-quote (concat "#+" property-name ":"))
                            ;;         " ?")
                            nil t)))
                (message "found here: %s" here)
                here)))))

(defhydra org-latex-hydra (org-mode-map "H-l" color: red columns: 2)
  "LATEX"
  ;; tested OK:
  ("l" pdflatex-compile-buffer "pdflatex tex buffer")
  ;; tested OK:
  ("L" xelatex-compile-buffer "xelatex tex buffer")
  ;;
  ("p" org-pdflatex-compile-buffer "pdflatex org buffer")
  ("P" org-pdflatex-compile-subtree "pdflatex org subtree")
  ;; ;; testing:
  ("x" org-xelatex-compile-buffer "xelatex org buffer")
  ("X" org-xelatex-compile-subtree "xelatex org subtree")
  ;; tested OK:
  ("t" org-latex-set-buffer-template "set buffer template")
  ;; tested OK:
  ("T" org-latex-set-subtree-template "set subtree template")
  ;; tested OK:
  ("?" org-latex-post-subtree-template-path "post subtree template path")
  ;; tested OK:
  ("/" org-latex-post-file-template-path "post file template path")
  ("f" org-latex-find-file-template-file "find file template file")
  ("F" org-latex-find-subtree-template-file "find subtree template file")
  ("q" quit "exit hydra" :exit t))

(global-set-key (kbd "H-l") 'org-latex-hydra)

(defun org-pdflatex-compile-buffer ()
  "Export buffer as body.tex and create pdf with pdflatex using template.
The template for the buffer is chosen by org-latex-get-file-template-path."
  (interactive)
  ;;                               pdflatexp subtreep
  (org-latex-compile-with-template t         nil))

(defun org-xelatex-compile-buffer ()
  "Export buffer as body.tex and create pdf with xelatex using template.
The template for the buffer is chosen by org-latex-get-file-template-path."
  (interactive)
  ;;                               pdflatexp subtreep
  (org-latex-compile-with-template nil        nil))

(defun org-pdflatex-compile-subtree ()
  "Export subtree as body.tex and create pdf with pdflatex using template.
The template for the buffer is chosen by org-latex-get-file-template-path."
  (interactive)
  ;;                               pdflatexp subtreep
  (org-latex-compile-with-template t         t))

(defun org-xelatex-compile-subtree ()
  "Export subtree as body.tex and create pdf with xelatex using template.
The template for the buffer is chosen by org-latex-get-file-template-path."
  (interactive)
  ;;                               pdflatexp subtreep
  (org-latex-compile-with-template nil        t))

(defun org-latex-compile-with-template (pdflatexp subtreep)
  "Export buffer or subtree as body.tex and create pdf using template.
If PDFLATEXP then use pdflatex, else use xelatex.
If SUBTREEP then export subtree only, else export entire buffer.
The template for the buffer is chosen by org-latex-get-file-template-path."
  (let*
      ((template-path (org-latex-get-file-template-path))
       (template-directory (file-name-directory template-path))
       (body-path (concat template-directory "body.tex"))
       (latex-output (org-export-as
                      ;; backend subtreep visible-only body-only ext-plist
                      'latex     subtreep      nil          t         nil
                      )))
    (with-temp-buffer
      (insert latex-output)
      (write-file body-path))
    (latex-compile-file-with-latexmk pdflatexp template-path)
    (message "Fuck you. I will save here: \n%s" body-path)))

(defun xelatex-compile-buffer ()
  "Compile current tex buffer into PDF using xelatex.
Use latexmk command as seen in org-mode export code."
  (interactive)
  (latex-compile-file-with-latexmk))

(defun pdflatex-compile-buffer ()
  "Compile current tex buffer into PDF using pdflatex.
Use latexmk command as seen in org-mode export code."
  (interactive)
  (latex-compile-file-with-latexmk t))

(defun latex-compile-file-with-latexmk (&optional pdflatexp filename)
  "Compile tex file using latexmk.
If PDFLATEXP then use pdflatex instead of xelatex.
Open resulting pdf file with default macos open method."
  (let* ((file (or filename (buffer-file-name)))
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
    (message "tex->pdf done. Opening:\n%s" (shell-quote-argument pdf-file))
    (shell-command (concat "open " (shell-quote-argument pdf-file)))))

(defun org-latex-post-file-template-path ()
  "Post the path of the latex template file for this file."
  (interactive)
  (message "The file template path is:\n%s" (org-latex-get-file-template-path)))

(defun org-latex-get-file-template-path ()
  "Get the path of the latex template file from the LATEX_HEADER_PATH property of this file."
  (save-excursion
    (org-with-wide-buffer
     (goto-char (point-min))
     (let* ((property-value (org-latex-default-template-path))
            (property-name "LATEX_HEADER_PATH")
            (here (re-search-forward
                   (concat "^"
                           (regexp-quote (concat "#+" property-name ":"))
                           " ?") nil t)))
       (message "found here: %s" here)
       (when here
         (goto-char here)
         ;; (message (buffer-substring-no-properties here (line-end-position)))
         (setq property-value (buffer-substring-no-properties here (line-end-position))))
       property-value))))

(defun org-latex-post-subtree-template-path ()
  "Post the path of the latex template file for current subtree."
  (interactive)
  (message "The subtree template path is:\n%s" (org-latex-get-subtree-template-path)))

(defun org-latex-get-subtree-template-path ()
  "Get path of the latex template file from LATEX_HEADER_PATH property of current subtree."
  (save-excursion
    (org-with-wide-buffer
     (goto-char (point-min)))
    (let* ((property-name "LATEX_HEADER_PATH")
           (property-value (org-entry-get (point) property-name)))
      (if property-value
          property-value
        (org-latex-get-file-template-path)))))

(defun org-latex-set-subtree-template ()
  "Set value of LATEX_HEADER_PATH property in current subtree."
  (interactive)
  (let ((path (org-latex-read-template-path)))
   (org-set-property "LATEX_HEADER_PATH" path)
   (message "You selected: \n%s" path)))

(defun org-latex-read-template-path ()
  "Read template path interactively from default folder."
  (let
      ((result
        (read-file-name "Select template file: " "~/latex-exports/templates" "framework.tex")))
    (if (file-directory-p result)
        (concat result "framework.tex")
      result)))

(defun org-latex-set-buffer-template ()
  "Set value of LATEX_HEADER_PATH property globally in current buffer."
  (interactive)
  (let ((path (org-latex-read-template-path)))
    (save-excursion
      (org-with-wide-buffer
       (goto-char (point-min))
       (let ((new-line "")
             (here (re-search-forward
                    (concat "^"
                            (regexp-quote (concat "#+" "LATEX_HEADER_PATH" ":"))
                            " ?") nil t)))
         (cond
          (here
           (goto-char here)
           (beginning-of-line)
           (kill-line))
          (t
           (setq new-line "\n")
           (goto-char (point-min))))
         (insert "#+LATEX_HEADER_PATH: " path new-line))))
    (message "You selected: \n%s" path)))

(defun org-latex-set-buffer-template ()
  "Set LATEX_HEADER_PATH property in current org buffer, globally"
  (interactive)
  (let ((template-path
         (read-file-name "Select template file: " "~/latex-exports/templates"
                         "framework.tex")))
    (message "You selected: %s\n" template-path)
    (save-excursion
      (org-with-wide-buffer
       (goto-char (point-min))
       (let ((here (re-search-forward
                    (concat "^"
                            (regexp-quote (concat "#+" "LATEX_HEADER_PATH" ":"))
                            " ?") nil t)))
         (cond
          (here
           (goto-char here)
           (beginning-of-line)
           (kill-line))
          (t
           (goto-char (point-min))))
         (insert "\n#+LATEX_HEADER_PATH: " template-path "\n"))))))

;; (defun org-pdflatex-compile-buffer ()
;;   "Compile buffer to pdf with pdflatex.
;; Use latex template given in property LATEX_HEADER_PATH.
;; If LATEX_HEADER_PATH is not defined in buffer, then use default path."
;;   (interactive)
;;   (org-compile-latex-with-custom-template t nil))

;; (defun org-xelatex-compile-buffer ()
;;   "Compile buffer to pdf with xelatex.
;; Use latex template given in property LATEX_HEADER_PATH.
;; If LATEX_HEADER_PATH is not defined in buffer, then use default path."
;;   (interactive)
;;   (org-compile-latex-with-custom-template nil nil))

;; (defun org-pdflatex-compile-subtree ()
;;   "Compile subtree to pdf with pdflatex.
;; Use latex template given in property LATEX_HEADER_PATH.
;; If LATEX_HEADER_PATH is not defined in buffer, then use default path."
;;   (interactive)
;;   (org-compile-latex-with-custom-template t t))

;; (defun org-xelatex-compile-subtree ()
;;   "Compile subtree to pdf with xelatex.
;; Use latex template given in property LATEX_HEADER_PATH.
;; If LATEX_HEADER_PATH is not defined in buffer, then use default path."
;;   (interactive)
;;   (org-compile-latex-with-custom-template nil t))

;; (defun org-compile-latex-with-custom-template (pdflatexp subtreep)
;;   "Compile to pdf using template path given in property.
;; If PDFLATEXP use pdflatex, else use xelatex.
;; If SUBTREEP compile only current subtree, else compile entire buffer.
;; This function is called by a family of 4 interactive functions
;; org-[pdf/xe]latex-compile-buffer/subtree) "
;;   (message "testing function. pdflatexp is: %s, subtreep is: %s\n"
;;            pdflatexp subtreep)
;;   (let* ((path-property-name "LATEX_HEADER_PATH")
;;          (template-path
;;           (cond
;;            (org-entry-get (point) path-property-name)))
;;          ()
;;          )
;;     ()
;;     ()
;;     ()
;;     )
;;   )

(defun org-get-custom-property (property-name)
  "Get property PROPERTY-NAME locally or globally."
  ;; (interactive "M")
  (unless property-name (setq property-name "LATEX_HEADER_PATH"))
  (let ((property-value (org-entry-get (point) property-name)))
    ;; (message "I found this: %s" property-value)
    (unless property-value
      (save-excursion
        (goto-char (point-min))
        (let ((here (re-search-forward
                     (concat "^"
                             (regexp-quote (concat "#+" property-name ":"))
                             " ?") nil t)))
          ;; (message "found here: %s" here)
          (when here
            (goto-char here)
            ;; (message (buffer-substring-no-properties here (line-end-position)))
            (setq property-value (buffer-substring-no-properties here (line-end-position))))
          )))
    property-value
    ))

;; (defun org-get-custom-property-draft (property-name)
;;   "Get property PROPERTY-NAME from current section or global proprty string encased in #+ :."
;;   (save-excursion
;;     (goto-char (point-min))
;;     (let ((here (re-search-forward
;;                  (concat "^"
;;                          (regexp-quote (concat "#+" property-name ":"))
;;                          " ?") nil t)))
;;       (message "found here: %s"
;;                here)
;;       (when here
;;         (goto-char here)
;;         (message (buffer-substring-no-properties here (line-end-position))))
;;       )
;;     )
;;   )
;; (defun org-compile-pdflatex-with-custom-headers ()
;;   "Export with pdflatex using custom latex headers if available."
;;   (interactive)
;;   (org-compile-latex-with-custom-headers t))

;; (defun org-compile-pdflatex-subtree-with-custom-headers ()
;;   "Export with pdflatex using custom latex headers if available."
;;   (interactive)
;;   (org-compile-latex-with-custom-headers t t))

;; (defun  org-compile-xelatex-with-custom-headers ()
;;   "Export with xelatex using custom latex headers if available."
;;   (interactive)
;;   (org-compile-latex-with-custom-headers))

;; (defun  org-compile-xelatex-subtree-with-custom-headers ()
;;   "Export with xelatex using custom latex headers if available."
;;   (interactive)
;;   (org-compile-latex-with-custom-headers nil t))

;; (defun org-compile-latex-with-custom-headers (&optional pdflatexp subtreep)
;;   "Export body, insert header+footer from sections, compile to pdf.
;;   If PDFLATEXP use pdflatex else use xelatex.
;;   Use latexmk as ORG-LATEX-PDF-PROCESS. This usually works for compiling bibtex
;;   and producing a bibliography section.
;;   If subtreep only compile the current org-subtree of the file.

;;   Create new filename based on user input, prompting with a file name
;;   constructed from the curent file and a datestamp.
;;   Save that file in the cache subdirectory of latex-exports.
;;   Insert latex header, footer, class definition sections in that file.
;;   Restore cursor position from the original file in the new file.
;;   Export file to pdf according to the options.

;;   This command assumes that we are already in the buffer of the file to be exported.
;;   "
;;   (org-prepare-latex-export-cache-dir)
;;   (let* (class header footer ;; these 3 variables are set later in the body of the let form.
;;                ;; get raw latex code from current buffer
;;                (latex-output (org-export-as
;;                               ;; backend subtreep visible-only body-only ext-plist
;;                               'latex  subtreep nil          t         nil
;;                               ))
;;                (source-file (buffer-file-name))
;;                (target-directory (org-get-latex-export-cache-directory))
;;                (template-file (concat target-directory "/"))
;;                (org-target-file
;;                 (concat
;;                  target-directory
;;                  "/"
;;                  (read-string
;;                   "File name base:"
;;                   (file-name-nondirectory (file-name-sans-extension source-file)))
;;                  "_"
;;                  (format-time-string "%y%m%d")
;;                  ".org"
;;                  ))
;;                (tex-target-file
;;                 (concat (file-name-sans-extension org-target-file) ".tex"))
;;                (pdf-file (concat
;;                           (file-name-sans-extension org-target-file)
;;                           ".pdf")))

;;     ;; Copy org source file to cache directory for reference
;;     (message "the source file is: %s\nThe target file is: %s" source-file org-target-file)
;;     (copy-file source-file org-target-file t)

;;     ;; provide default bib file if missing
;;     (unless
;;         (file-expand-wildcards (concat target-directory "/*.bib"))
;;       (make-symbolic-link
;;        org-latex-bib-full-path
;;        (concat target-directory "/bibliography.bib")))

;;     ;; get latex class, header and footer from template file

;;     (find-file (concat target-directory "/latex-template.org"))
;;     (setq class (get-class-from-section))
;;     (setq header (get-custom-latex-from-section "latex-header"))
;;     (setq footer (get-custom-latex-from-section "latex-footer"))
;;     (kill-buffer (current-buffer))
;;     ;; Insert class, header, footer to latex output and export to pdf
;;     (with-temp-buffer
;;       (unless (has-documentclass header) (insert (cadr class) "\n"))
;;       (insert header)
;;       (insert latex-output)
;;       (insert footer)
;;       (let ((coding-system-for-write 'utf-8)
;;             (org-latex-pdf-process
;;              (if pdflatexp
;;                  '("latexmk -shell-escape -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
;;                '("latexmk -shell-escape -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
;;         ;;
;;         (write-file tex-target-file)
;;         (message "org-latex-default-class is:\n%s" org-latex-default-class)
;;         (message "org latex classes are:\n%s" org-latex-classes)
;;         (message "latex compile command is:\n %s" org-latex-pdf-process)
;;         ;; (org-latex-compile (buffer-file-name))
;;         (cleanup-bbl-and-compile-latex (buffer-file-name))
;;         (message "org-latex compile to PDF done. Opening:\n%s" (shell-quote-argument pdf-file))
;;         (copy-file pdf-file (concat org-latex-export-path "/"
;;                                     (file-name-nondirectory pdf-file)) t)
;;         (shell-command (concat "open " (shell-quote-argument pdf-file)))))))

;; (defun has-documentclass (string)
;;   "Return if string contains documentclass."
;;   (if (string-match "documentclass" string)
;;       t
;;     nil))

;; (defun test-doclass ()
;;   "temporary test function"
;;   (interactive)
;;   (message "Is: %s"
;;            (has-documentclass (buffer-substring-no-properties (point-min) (point-max)))))

;; (defun cleanup-bbl-and-compile-latex (filename)
;;   "Remove bbl file before compiling, to ensure bibliography is compiled anew."
;;   (message "deleting bbl file:\n%s\n" (concat (file-name-sans-extension filename) ".bbl"))
;;   (delete-file (concat (file-name-sans-extension filename) ".bbl"))
;;   (org-latex-compile filename))

;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; The following functions must be rewritten.
;; ;; latex-compile-file-with-xelatex
;; ;; latex-compile-file-with-pdflatex
;; ;; latex-compile-file-with-latexmk
;; ;; Note: These functions are not used by org-compile-latex-with-custom-headers

;; (defun latex-compile-file-with-xelatex ()
;;   "Compile tex file with xelatex and open resulting pdf file."
;;   (interactive)
;;   (latex-compile-file-with-latexmk))

;; (defun latex-compile-file-with-pdflatex ()
;;   "Compile tex file with pdflatex and open resulting pdf file."
;;   (interactive)
;;   (latex-compile-file-with-latexmk t))

;; (defun latex-select-compile-file-with-latexmk (&optional pdflatexp)
;;   "Compile tex file using latexmk.
;;       If PDFLATEXP then use pdflatex instead of xelatex.
;;       Open resulting pdf file with default macos open method."
;;   (interactive "P")
;;   (let* ((file (buffer-file-name))
;;          (pdf-file (concat
;;                     (file-name-sans-extension file)
;;                     ".pdf"))
;;          (org-latex-pdf-process
;;           (if pdflatexp
;;               '("latexmk -shell-escape -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
;;             '("latexmk -shell-escape -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
;;     (message "latex compile command is:\n %s" org-latex-pdf-process)
;;     (delete-file (concat (file-name-sans-extension file) ".bbl"))
;;     (org-latex-compile file)
;;     ;; following was wrong!!!!!!!!!
;;     ;;    (cleanup-bbl-and-compile-latex (file))
;;     (message "tex->pdf done. Opening:\n%s" (shell-quote-argument pdf-file))
;;     (shell-command (concat "open " (shell-quote-argument pdf-file)))))

;; (defun latex-select-main-file (&optional filename)
;;   "Select main file for latex compilation interactively."
;;   (interactive "fSelect file (default: this buffer): ")
;;   (message "You selected: \n%s" filename)
;;   )

;; (defun latex-compile-file-with-latexmk (&optional pdflatexp filename)
;;   "Compile tex file using latexmk.
;;       If PDFLATEXP then use pdflatex instead of xelatex.
;;       Open resulting pdf file with default macos open method."
;;   ;; (interactive)
;;   (let* ((file (or filename (buffer-file-name)))
;;          (pdf-file (concat
;;                     (file-name-sans-extension file)
;;                     ".pdf"))
;;          (org-latex-pdf-process
;;           (if pdflatexp
;;               '("latexmk -shell-escape -g -pdf -pdflatex=\"pdflatex\" -outdir=%o %f")
;;             '("latexmk -shell-escape -g -pdf -pdflatex=\"xelatex\" -outdir=%o %f"))))
;;     (message "latex compile command is:\n %s" org-latex-pdf-process)
;;     (delete-file (concat (file-name-sans-extension file) ".bbl"))
;;     (org-latex-compile file)
;;     ;; following was wrong!!!!!!!!!
;;     ;;    (cleanup-bbl-and-compile-latex (file))
;;     (message "tex->pdf done. Opening:\n%s" (shell-quote-argument pdf-file))
;;     (shell-command (concat "open " (shell-quote-argument pdf-file)))))

;; (defcustom latex-blocks-alist
;;   '(
;;     ;; "\\documentclass{article}" has been removed!
;;     ("latex-header" . "\\begin{document}")
;;     ("latex-footer" . "\\end{document}"))
;;   "Alist of default latex block strings for header/footer.")

;; (defun get-custom-latex-from-section (&optional section-name)
;;   "Provide header or footer latex code from section named SECTION-NAME.
;;     Get default code from LATEX-BLOCKS-ALIST."
;;   (setq section-name (or section-name "latex-header"))
;;   (let ((code (or
;;                (cdr (assoc section-name latex-blocks-alist))
;;                "")))
;;     (org-map-entries
;;      (lambda ()
;;        (let ((element (cadr (org-element-at-point))))
;;          (when (string= section-name (plist-get element :title))
;;            (setq code (get-contents-or-babel element)))
;;          )))
;;     code))

;; (defun get-class-from-section (&optional section-name)
;;   "Get latex class from section named SECTION-NAME.
;;     If class was found, add it to org-latex-classes.
;;     Return class."
;;   (setq section-name (or section-name "latex-class"))
;;   (let ((code "") class)
;;     (org-map-entries
;;      (lambda ()
;;        (let ((element (cadr (org-element-at-point))))
;;          (when (string= section-name (plist-get element :title))
;;            (setq code (get-contents-or-babel element))
;;            (setq class (eval (car (read-from-string code))))
;;            ))))
;;     (if
;;         class
;;         (add-to-list 'org-latex-classes class)
;;       (setq class '("article" "\\documentclass[10pt]{article}")))
;;     (message "I AM SETTING CLASS TO THIS:\n%s" class)
;;     class))

;; (defun get-latex-section (&optional section-name)
;;   "Get entire section with name matching SECTION-NAME."
;;   (setq section-name (or section-name "latex-header"))
;;   (let ((code (or
;;                (cdr (assoc section-name latex-blocks-alist))
;;                "")))
;;     (org-map-entries
;;      (lambda ()
;;        (let ((element (cadr (org-element-at-point))))
;;          (when (string= section-name (plist-get element :title))
;;            (org-copy-subtree)
;;            (setq code (current-kill 0)))
;;          )))
;;     code))

;; (defun get-contents-or-babel (element)
;;   "Get contents of section or babel block as string from ELEMENT."
;;   (let* ((result (buffer-substring-no-properties
;;                   (plist-get element :contents-begin)
;;                   (plist-get element :contents-end)))
;;          (src-block-beginning
;;           (string-match "^#\\\+BEGIN_SRC +[a-z-]+" result))
;;          (src-content-beginning
;;           (match-end 0)))
;;     (when src-block-beginning
;;       (setq result (substring
;;                     result
;;                     src-content-beginning
;;                     (or
;;                      ;; if no end of block was found, use end of section contents
;;                      (string-match "^#\\\+END_SRC" result)
;;                      (string-width result)))))
;;     result))

;;     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; use deft to select and insert custom headers for latex export

;; ;; Browse recipes using deft.  Deft setup:
;; (prelude-load-require-packages '(deft))
;; (eval-after-load 'deft
;;   '(progn
;;      (define-key deft-mode-map (kbd "C-i") 'deft-select-latex-headers)
;;      ;; prelude overrides this. FIX IT!:
;;      ;; (define-key deft-mode-map [(shift return)] 'deft-select-latex-headers)
;;      ;; (define-key deft-mode-map (kbd "S-RET") 'deft-select-latex-headers)
;;      (setq deft-current-sort-method 'title)))

;; (setq deft-use-filename-as-title t)

;; ;; include org, sc, el, txt, tex files in deft search
;; (setq deft-extensions '( "org" "txt"))

;; ;; use latex-recipes as deft directory
;; (setq deft-directory (concat (directory-file-name
;;                               (file-name-directory
;;                                (directory-file-name
;;                                 (file-name-directory (directory-file-name load-file-name)))))
;;                              "/latex-recipes/"))

;; (setq deft-use-filter-string-for-filename t) ;; create file names from user input - not timestamps

;; ;; search directories recursively in deft
;; (setq deft-recursive t)

;; ;; Functions for getting headers from deft
;; (defun deft-select-latex-headers ()
;;   "Store path of selected latex-recipe file to latex-export template file.
;;   This is used by org-prepare-latex-export-cache-dir."
;;   (interactive)
;;   (let* ((cache-dir (org-get-latex-export-cache-directory))
;;          (source-file (file-truename (deft-filename-at-point)))
;;          (source-directory (file-name-directory source-file)))
;;     ;; (when (directory-name-p cache-dir)
;;     ;;   (delete-directory cache-dir t t))
;;     ;; (copy-directory source-directory cache-dir t t t)
;;     ;; (copy-file source-file (concat cache-dir "/latex-template.org") t)
;;     (with-temp-buffer
;;       (insert source-file)
;;       ;; the next line should be removed
;;       ;; (write-file (concat cache-dir "/template-file-path.txt"))
;;       ;; the next line should be kept
;;       (write-file (org-get-latex-export-template-file-path)))
;;     (message "template set to: %s" source-file)))

;; (defun org-prepare-latex-export-cache-dir ()
;;   "Copy template directory to latex-export cache directory.
;;   Also copy template source file to latex-template.
;;   Evaluated by latex-compile-file-with-latexmk before each compilation.
;;   This ensures that any changes made in the template will be adopted
;;   at latex compilation."
;;   (let* ((cache-dir (org-get-latex-export-cache-directory))
;;          (source-file (with-temp-buffer
;;                         (insert-file-contents (org-get-latex-export-template-file-path))
;;                         (car (split-string (buffer-string) "\n" t))))
;;          (source-directory (file-name-directory source-file)))
;;     (when (file-directory-p cache-dir)
;;       (delete-directory cache-dir t t))
;;     (copy-directory source-directory cache-dir t t t)
;;     (copy-file source-file (concat cache-dir "/latex-template.org") t)
;;     ;; (with-temp-buffer
;;     ;;   (insert source-file)
;;     ;;   ;; the next line should be removed
;;     ;;   (write-file (concat cache-dir "/template-file-path.txt"))
;;     ;;   ;; the next line should be kept
;;     ;;   (write-file (org-get-latex-export-template-file-path)))
;;     ;; (message "template set to: %s" source-file)
;;     ))

;; (defun org-get-latex-export-cache-directory ()
;;   "Return path of latex-export-cache subdirectory."
;;   (concat org-latex-export-path "/cache"))

;; (defun org-get-latex-export-template-file-path ()
;;   "Return path of file containing the latex-export-file-template."
;;   (concat org-latex-export-path "/template-file-path.txt"))

;; (defun org-post-current-latex-export-template ()
;;   "Post file name of latex-template from latex-exports cache subdirectory."
;;   (interactive)
;;   (let* ((template-file (org-get-latex-export-template-file-path))
;;          (template (if (file-exists-p template-file)
;;                        (with-temp-buffer
;;                          (insert-file-contents template-file)
;;                          (buffer-string))
;;                      nil)))
;;     (if template
;;         (message "The template file is: %sIts folder is: %s"
;;                  (file-name-nondirectory template)
;;                  (file-name-directory template))
;;       (message "no template file found at %s" template-file))))

;; (defun org-get-latex-template-file-path ()
;;   "Return path of latex-tempalte-file name from leatex-exports cache subdirectory."
;;   (concat (org-get-latex-export-cache-directory) "/template-file-path.txt"))

;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;Compile multi-file latex with includes
;;   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (defcustom org-latex-main-folder (concat org-latex-export-path "/latex-templates/default")
;;   "Path of folder for compiling mult-file include latex projects")

;; ;; TODO: Finish this!
;; ;; (defcustom org-latex-header-file
;; ;;   "Path of folder for compiling mult-file include latex projects")

;; (defun org-latex-compile-main (&optional pdflatex)
;;   "Create includes, concatenate main and compile it using ORG-LATEX-MAIN-FOLDER path.
;;   Use latex-compile-file-with-latexmk (&optional pdflatexp filename)"
;;   (interactive "P")
;;   (let ((main-file-name (org-latex-main-folder "/main.tex"))
;;         (header-file )
;;         (main-includes)
;;         (footer-file))
;;     ;; concate header, main, footer to create main.tex
;;     (with-temp-buffer
;;       (insert-file-contents header-file)
;;       (insert main-includes)
;;       (insert-file-contents footer-file)
;;       (write-file main-file-name))
;;     (latex-compile-file-with-latexmk pdflatex main-file-name)))

(message "FUCK YOU")
