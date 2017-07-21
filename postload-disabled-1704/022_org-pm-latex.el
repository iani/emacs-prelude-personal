;;; Obsolete:
;; (defvar org-pm-latex-template-root (expand-file-name "~/latex-templates/")
;;   "Folder storing latex templates")

;; (unless (file-exists-p org-pm-latex-template-root)
;;   (make-directory org-pm-latex-template-root t))

;; (eval-after-load 'org
;;   '(progn
;;      (define-key org-mode-map (kbd "C-c C-x l") 'org-pm-export-latex)))

;;; ================================================================
;;; End obsolete.
;;; ================================================================

;;; Simplify:

;;; Use Auctec and xelatex / xetex as default tex rendering engine.
;; Requires that auctex is installed (use package-install)

(setq-default TeX-engine 'xetex)

(defcustom custom-latex-headers (concat
                            (file-name-directory load-file-name)
                            "latex/org-latex-headers.org")
  "Path of org file containing custom latex headers")

(defun latex-headers-open ()
  (interactive)
  (find-file custom-latex-headers))

(defun latex-header-prepend ()
  "Replace default org-produced latex header with a custom one chosen from a file."
  (interactive)
  ;; first discard old header
  ;; search to \author
  ;; cut all lines from beginning of buffer to the line preceding \author
  ;; select file of header
  ;; save file in same folder as header
  ;; (get ready for export with C-c C-c, or run tex-export and then open the pdf file
  ;; ...
  (let*
      ((target-file (progn
                      (goto-char 0)
                      (re-search-forward "\\\\title{\\(.*\\)}")
                      (replace-regexp-in-string
                              "[^[:alnum:]-_]" "" (match-string-no-properties 1)))))
    (write-file (concat
                 (file-name-directory
                  (read-file-name "Choose target header file location: "))
                 (if (= (length target-file) 0)
                     "latex-export"
                     target-file)
                 ".tex")))
  (goto-char 0)
  (re-search-forward "\\\\author{\\(.+\\)}")
  (beginning-of-line)
  (delete-region 1 (point))
  (goto-char 0)
  (yank))

(defun latex-header-strip-default ()
  "Strip default latex header from buffer, up to the author declaration statement."
  (interactive)
  (goto-char 0)
  (re-search-forward "\\\\author{\\(.+\\)}")
  (beginning-of-line)
  (delete-region 1 (point))
  (goto-char 0))

(defun latex-header-copy ()
  (interactive)
  (outline-back-to-heading)
  (let ((section-begin
         (plist-get (cadr (org-element-at-point)) :contents-begin)))
    (goto-char section-begin)
    ;; (message "%s" (plist-get (cadr (org-element-at-point)) :value))
    (kill-new (plist-get (cadr (org-element-at-point)) :value)))
  )

;;; Candidate keyboard-command group:
;;; C-S-c C-S-l [
;;; g: insert custom header for greek article,
;;; o: open org-file with custom headers for various formats
;;; H: strip header 
;;; ... ]
