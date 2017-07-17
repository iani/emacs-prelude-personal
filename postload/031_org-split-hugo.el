;;; 031_org-split-hugo --- export sections to files for hugo

;;; Commentary:
;;; 16 Jul 2017 13:07
;;; Draft of function to split an entire org-file into subfiles for export
;;; to hugo.
;;; The contents of any section that has a property "filename" will be
;;; exported under the same directory as the source file.
;;; the filename property gives the filename.
;;; the heading becomes title property in yaml front-matter.
;;; the weight is set according to the order of the exported sections.
;;; TODO: sections with property "foldername" append the string value
;;; of the property to the folder path, and create the folder if it does not
;;; exist.
;;; Start by obtaining the root path from the file being exported.
;;; Append the cumulave folder path constructed by nested folderpath properties.
;;; Use it for all subsequent exported sections (until reset by other section)
;;; Use "/" at the beginning of the foldername to denote return to local root
;;; instead of appending the foldername.
;;; Construct _index.md from the name of the folder section.
;;; Increment a folder_index variable to set weight for folder _index.md.

;;; Code:

(defun org-hugo-autosplit ()
  "Auto-export sections marked with filename property after each save."
  (interactive)
 (add-hook 'after-save-hook
           (lambda ()
             (org-split-hugo)
             ;; (message "hugo export to individual files done")
             )
           'append 'local)
 (message "This buffer will now export to hugo section files after each save."))


(defun org-split-hugo ()
  "Split 1st level sections with filename property to files.
Add front-matter for hugo, including automatic weights."
  (interactive)
  (let
      ((root-dir (file-name-directory (buffer-file-name)))
       (index 0))
    (org-map-entries
     '(org-split-1-file-hugo)
     t 'file 'archive 'comment)
    (message "Exported %d files" index)))

(defun org-split-1-file-hugo ()
  "Helper function for org-split-hugo."
  (let
      ((fname (org-entry-get (point) "filename"))
       (element (cadr (org-element-at-point))))
    (when fname
      (setq index (+ 1 index))
      (goto-char (plist-get element :begin))
      (org-copy-subtree)
      (find-file (format "%03d-%s.org" index fname))
      (erase-buffer)
      (org-paste-subtree 1)
      (org-show-subtree)
      (kill-line)
      (kill-line)
      (re-search-forward ":PROPERTIES:")
      (replace-match "+++")
      (re-search-forward ":filename: ")
      (beginning-of-line)
      (kill-line)
      (insert-string (format "title = \"%s\"\n"
                             (plist-get element :title)))
      (insert-string (format "weight = %d" index))
      (re-search-forward ":END:")
      (replace-match "+++")
      (org-map-entries '(org-promote))
      ;; subsections were pasted as level 2
      (save-buffer)
      (kill-buffer))))

(provide '031_org-split-hugo)
;;; 031_org-split-hugo.el ends here
