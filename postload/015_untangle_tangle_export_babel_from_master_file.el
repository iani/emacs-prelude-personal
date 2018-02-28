;;; untangle_tangle_export_babel_from_master_file --- 2018-02-28 04:14:10 PM
;;; Commentary:
;;; org-el-untangle:
;;; import muliple el files from one folder into one org mode file.
;;; org-el-tangle-sections
;;; export each sections' emacs-lisp block to a separate file.

;;; Code:

(defun org-el-import-all-files (directory)
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
    (insert "#+STARTUP: overview\n")
    (goto-char (point-max))
    (mapc 'org-el-import-1-file files)))

(defun org-el-import-1-file (fname)
  "Insert file FNAME into the master org file.
Create org header and SRC block from data in FNAME file."
  (message fname)
  (save-excursion
    (let*
        ((fname-base (substring (file-name-base fname) 4 nil))
         found body-start body-end body)
      (find-file fname)
      (goto-char (point-min)) ;; in case we are already editing the buffer!
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
        (insert (replace-regexp-in-string
                 "  " " "
                 (format "\n* %s\n"
                         (replace-regexp-in-string "_" " " fname-base))))
        (insert "\n#+BEGIN_SRC emacs-lisp\n")
        (insert body)
        (insert "#+END_SRC")))))

(defun org-el-export-all-sections ()
  "Export each sections' emacs-lisp block to a separate file.
Add header and footer parts required by flycheck."
  (interactive)
  (let
      ((index 0)
       (root-dir (file-name-directory (buffer-file-name)))
       buffers)
    ;;; First delete old entries, before creating new ones.
    ;;; Prevent duplicate entries due to renumbering.
    (mapc 'delete-file (file-expand-wildcards (concat root-dir "*.el")))
    (org-map-entries 'org-el-export-1-section)
    (mapc 'kill-buffer buffers)))

(defun org-el-export-1-section ()
  "Export this sections' emacs-lisp block to a separate file.
Add header and footer parts required by flycheck.
Skip sections marked with COMMENT."
  (let* (body-element
         (element (cadr (org-element-at-point)))
         (title (plist-get element :title))
         (commented (plist-get element :commentedp))
         (filename))
    ;; skip commented sections
    (unless commented
      (setq index (+ 1 index))
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
      (setq buffers (cons (current-buffer) buffers))
      (kill-buffer))))

(eval-after-load 'org
  '(progn
     ;; Note: This keybinding is in analogy to the default keybinding:
     ;; C-c . -> org-time-stamp
     (define-key org-mode-map (kbd "C-c C-M-e") 'org-el-export-all-sections)))
(provide 'untangle_tangle_export_babel_from_master_file)
;;; 015_untangle_tangle_export_babel_from_master_file.el ends here
