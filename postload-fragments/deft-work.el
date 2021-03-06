;;; NOTE: See notes in master file about upgrading to org-mode version 9.
;;; This is needed to use xelatex.

;; First load this package to initialize variables:
(require 'ox-latex)

;; Use xelatex as latex compiler, thus enabling use of native fonts for greek etc.
(setq org-latex-compiler "xelatex")

;; Add some latex classes.  Testing stage.  Keepin this simple for now.
(add-to-list 'org-latex-classes '("letter" "\\documentclass[11pt]{scrlttr2}"))
;; See example letter in folder ../latex-examples

;; use fontspec package to enable system fonts in xelatex
(add-to-list 'org-latex-packages-alist '("" "fontspec"))
;; allow more flexible spaces between words for justified text
(add-to-list 'org-latex-packages-alist "\\sloppy")

;; Browse recipes using deft
(prelude-load-require-packages '(deft))
(eval-after-load 'deft
  '(progn
     (define-key deft-mode-map (kbd "C-i") 'deft-insert-latex-headers)))

(defun deft-insert-latex-headers ()
  "Get latex headers from current file and append them to ORG-CURRENT-BUFFER.
ORG-CURRENT-BUFFER is set from org-latex-insert-headers-recipe."
  (interactive)
  (if (null org-current-buffer)
      (message "there is no current buffer to insert headers.")
    (let ((filename (deft-filename-at-point))
          (headers "") (header ""))
        (setq footer (get-latex-section "latex-footer")))
      (with-current-buffer org-current-buffer
        (goto-char (point-max))
        (insert header "\n" footer)))))

(defun get-latex-section (&optional section-name)
  "Get entire section with name matching SECTION-NAME."
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
           (org-copy-subtree)
           (setq code (current-kill 0)))
         )))
    code))

;; OBSOLETE:
;; (defun deft-insert-file-other-buffer ()
;;   "Copy contents of file selected in deft window to kill ring."
;;   (interactive)
;;   (let ((filename (deft-filename-at-point)))
;;     (unless filename
;;       (goto-char (line-beginning-position))
;;       (setq filename (deft-filename-at-point)))
;;     (when filename
;;       (message "test %s" filename)
;;       (other-window 1)
;;       (goto-char (point-min))
;;       (insert-file-contents filename))))

(setq deft-use-filename-as-title t)

;; include org, sc, el, txt, tex files in deft search
(setq deft-extensions '( "org" "sc" "scd" "el" "txt" "tex"))

;; use latex-recipes as deft directory
(setq deft-directory (concat (directory-file-name
                              (file-name-directory
                               (directory-file-name
                                (file-name-directory (directory-file-name load-file-name)))))
                             "/latex-recipes/"))

(setq deft-use-filter-string-for-filename t) ;; create file names from user input - not timestamps

;; search directories recursively in deft
(setq deft-recursive t)
