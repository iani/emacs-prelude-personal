;;; hugo-export-sections-draft --- export sections to files for hugo

;;; Commentary:
;;; 16 Jul 2017 13:07
;;; Draft of function to split an entire org-file into subfiles for export
;;; to hugo.
;;; The contents of any section that has a property "filename" will be
;;; exported under the same directory as the source file.
;;; the filename property gives the filename.
;;; the heading becomes title property in yaml front-matter.
;;; the weight is set according to the order of the exported sections.
;;; TODO: 1 replace BEGIN, END filename strings to make front-matter
;;; TODO: 2 insert weight in front matter, from index
;;; TODO: 3 Demote all subtrees of level 2 by 1.
;;; Note: 3 presupposes that only trees of level 1 are to be split into files.
;;; It is possible to generalize this for any level, but not worth the trouble for now.

;;; Code:

(defun org-map-test ()
  (let ((fname (org-entry-get (point) "filename")))
    (when fname
      (setq index (+ 1 index))
      ;; (format "%s -/- %s, %03d-%s"
      ;;         fname
      ;;           (plist-get (cadr (org-element-at-point)) :raw-value)
      ;;           index
      ;;           (org-entry-get (point) "noexistentname"))
      (let*
          ((element (cadr (org-element-at-point)))
           (begin (plist-get element :contents-begin))
           (end (plist-get element :contents-end)))
        ;; (message "%s" (buffer-substring-no-properties begin end))
        (format "%s %03d - %d %d" fname index begin end)
        element
        ;; 
        )
      )))

(let ((index 0))
  (org-map-entries
   '(org-map-test)
   t 'file 'archive 'comment))

(defun org-split-hugo ()
  "Split 1st level sections with filename property to files.
Add front-matter for hugo, including automatic weights."
  (interactive)
  (let
      ((root-dir (file-name-directory (buffer-file-name)))
       (index 0))
    (org-map-entries
     '(org-split-1-file-hugo)
     t 'file 'archive 'comment)))

(defun org-split-1-file-hugo ()
  "Helper function for org-split-hugo."
  (let
      ((fname (org-entry-get (point) "filename"))
       (element (cadr (org-element-at-point)))
       contents)
    (when fname
      (setq index (+ 1 index))
      (setq contents (buffer-substring-no-properties
                      (plist-get element :contents-begin)
                      (plist-get element :contents-end)))
      (find-file (format "%03d-%s.org" index fname))
      (insert-string contents)
      (goto-char (point-min))
      (re-search-forward ":PROPERTIES:")
      (replace-match "+++")
      (re-search-forward ":filename: ")
      (replace-match "title = \"")
      (delete-horizontal-space)
      (end-of-line)
      (delete-horizontal-space)
      (insert-string "\"\n")
      (insert-string (format "weight = %d" index))
      (re-search-forward ":END:")
      (replace-match "+++")
      ;; (org-map-entries '(org-promote) t 'file 'comment)
      ;; (org-promote-all-entries)
      (org-map-entries '(org-promote))
      (save-buffer))))

(defun org-promote-all-entries ()
  "Promote all entries in this file"
  (interactive)
  (org-map-entries '(org-promote) t 'file 'comment))

(provide 'hugo-export-sections-draft)
;;; hugo-export-sections-draft.el ends here
