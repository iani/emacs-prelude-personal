;;; 006_untangle_tangle --- import multiple el files to org and v.v.

;;; Commentary:
;;; org-el-untangle:
;;; import muliple el files from one folder into one org mode file.
;;; org-el-tangle-sections
;;; export each sections' emacs-lisp block to a separate file.

;;; Code:

(defun org-el-untangle (directory)
  "Import muliple el files from one folder into one org mode file."
  (interactive "D")
  (let
      ((filename (concat "MASTER-FILE-" (format-time-string "%y%m%d") ".org"))
       (files (file-expand-wildcards (concat directory "*.el")))
       (target-buffer))
    ;; (message (concat (file-truename directory) filename))
    (find-file filename)
    (erase-buffer)
    (setq target-buffer (current-buffer))
    (mapc 'org-el-insert-1-file files)))

(defun org-el-insert-1-file (fname)
  "Insert file FNAME into the master org file.
Create org header and SRC block from data in FNAME file."
  (message fname)
  (save-excursion
    (let*
        ((fname-base (file-name-base fname))
         (header (concat
                  "\n* "
                  (replace-regexp-in-string "_" " " (substring fname-base 3 nil))
                  "\n"))
         found body-start body-end body)
      (find-file fname)
      (goto-char (point-min))
      (setq found
            (search-forward fname-base (line-end-position 1) t 1))
      (cond
       (found
        (forward-line 1)
        (setq body-start (point)))
       (t (setq body-start (point-min))))
      (setq found
            (search-forward (format "provide '%s" fname-base) nil t 1))
      (cond
       (found (setq body-end (line-beginning-position)))
       (t (setq body-end (point-max))))
      (setq body (buffer-substring body-start body-end))
      (kill-buffer (current-buffer))
      (with-current-buffer target-buffer
        (goto-char (point-max))
        (insert (replace-regexp-in-string "  " " " header))
        (insert "\n#+BEGIN_SRC emacs-lisp\n")
        (insert body)
        (insert "#+END_SRC\n\n")))))

(defun org-el-tangle-sections ()
  "Export each sections' emacs-lisp block to a separate file.
Add header and footer parts required by flycheck."
  (interactive)
  (let
      ((index 0)
       (root-dir (file-name-directory (buffer-file-name))))
   (org-map-entries 'org-el-tangle-1-section)))

(defun org-el-tangle-1-section ()
  "Export this sections' emacs-lisp block to a separate file.
Add header and footer parts required by flycheck.
Skip sections marked with COMMENT."
  (setq index (+ 1 index))
  (let* (body-element
         (element (cadr (org-element-at-point)))
         (title (plist-get element :title))
         (filename
          ))
    ;; skip commented sections
    (unless (string-match "^COMMENT" title)
      (search-forward "#+BEGIN_SRC")
      (setq body-element (cadr (org-element-at-point)))
      ;; (message
      ;;  (replace-regexp-in-string " " "_" (plist-get element :title)))
      ;; (message "%s" body-element)
      (setq title (replace-regexp-in-string " " "_" title))
      (setq filename (format "%03d_%s.el" index title))
      (find-file filename)
      (erase-buffer)
      (insert (format ";;; %s --- %s"
                      title
                      (format-time-string "%F %r\n")))
      (goto-char (point-max))
      (insert (plist-get body-element :value))
      (goto-char (point-max))
      (insert (format "(provide '%s)\n;;; %s ends here" title filename))
      (save-buffer)
      (kill-buffer))))

(provide '006_untangle_tangle)
;;; 006_untangle_tangle ends here
