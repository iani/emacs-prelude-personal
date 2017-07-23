;;; org-split-hugo --- 2017-07-23 09:38:43 AM

  ;;; Commentary:
  ;;; Utilities for blog + website editing with HUGO

  ;;; org-hugo-autosplit: split an entire org-file into subfiles for export to hugo.
  ;;; The contents of any section that has a property "filename" will be
  ;;; exported under the same directory as the source file.
  ;;; the filename property gives the filename.
  ;;; the heading becomes title property in yaml front-matter.
  ;;; the weight is set according to the order of the exported sections.
  ;;;
  ;;; Sections with property "foldername" set a subfolder for saving
  ;;; subsequent file sections.
  ;;; Folder path is constructed by concatenating a cumulative list of subfolders.
  ;;; "/path" resets the list to '("path")
  ;;; "+path" appends "path" to the folder list.
  ;;; "path" replaces (sets) the last element of the folder list by (to) "path".
  ;;; Use it for all subsequent exported sections (until reset by other section)
  ;;; Construct _index.md from the name of the folder section.
  ;;; Increment a folder_index variable to set weight for folder _index.md.

  ;;; Code:

  ;;; provides commands for hugo config, page creation, publish etc:
  (prelude-load-require-package 'easy-hugo)

  ;;; org-check-agenda-file stops the file creation process
  ;;; and therefore must be redefined here.
  ;;; Consequences of overwriting it are not yet checked, but seem irrelevant.
  (defun org-check-agenda-file (file)
    "Make sure FILE exists.  If not, ask user what to do."
    (unless (file-exists-p file)
      (message "Ignoring non-existent agenda file: %s"
               (abbreviate-file-name file))))

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
    (let*
        ((root-dir (file-name-directory (buffer-file-name)))
         (path root-dir)
         (folder_components)
         (index 0)
         folderindex ;; initialized from index upon first folder
         buffers-to-delete)
      (org-map-entries
       '(org-split-1-file-or-folder-hugo)
       t 'file 'archive 'comment)
      (mapc (lambda (buffer)
              (message "killing buffer: %s" buffer)
              (set-buffer-modified-p nil)
              (kill-buffer buffer))
            buffers-to-delete)
      (message "Exported %d files" index)))

  (global-set-key (kbd "C-c C-h C-h") 'org-split-hugo)

  (defun org-split-1-file-or-folder-hugo ()
    "Helper function for org-split-hugo
  DRAFT TO INCLUDE FOLDERS."
    (let*
        ((filename (org-entry-get (point) "filename"))
         (foldername (org-entry-get (point) "foldername"))
         (element (cadr (org-element-at-point)))
         (title (plist-get element :title))
         initial)
      (cond
       (foldername
    ;;; initialize folder order counter if needed
        (if folderindex
            (setq folderindex (+ 1 folderindex))
          (setq folderindex (+1 index)))
        (setq initial (substring foldername 0 1))
        (org-hugo-make-folder))
       (filename (org-hugo-make-file)))))

  (defun org-hugo-make-folder ()
    ;;; create foldername
    (cond
     ;; reset folder components to given foldLername
     ((equal initial "/")
      (setq folder_components (list (folderify (substring foldername 1 nil)))))
     ;; add  foldername to folder components
     ((equal initial "+")
      (setq folder_components
            (append folder_components (list (folderify (substring foldername 1 nil))))))
     ;; replace last folder component by foldername
     (t
      (unless folder_components
        (setq folder_components '(1)))
      (setf (nth (- (length folder_components) 1) folder_components)
              (folderify foldername))))
    ;;; create folder if needed
    (setq path (concat root-dir (apply 'concat folder_components)))
    (make-directory path t)
    ;;; cleanup: remove previous exports
    (let*
        ((all (file-expand-wildcards (concat path "*.org"))))
      (mapc (lambda (path)
              (message "%s" path)
              (message "%s" (string-match  "[[:digit:]]+-[^.]*\.org" path))
              (if (string-match  "[[:digit:]]+-[^.]*\.org" path)
                  (delete-file path)))
            all))
      ;;; create _index.md file, use heading for title, add folderindex as weight.
    (find-file
     (concat path "_index.md"))
    (erase-buffer)
    (insert-string
     "+++\n"
     "title = \""
     title
     (format "\"\nweight = %d\n+++\n" folderindex))
    (save-buffer)
    (kill-buffer))

  (defun folderify (string)
    "add trailing / to turn STRING into folder name."
    (if (equal "/" (substring string -1 nil))
        string
      (concat string "/")))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun org-hugo-make-file ()
    (setq index (+ 1 index))
    (unless path)
    (goto-char (plist-get element :begin))
    (org-copy-subtree)
    (find-file (format "%03d-%s.org" index filename))
    (find-file (format "%s%03d-%s.org" path index filename))
    (erase-buffer)
    (org-paste-subtree 1)
    (org-show-subtree)
    (kill-line)
    (kill-line)
    (re-search-forward ":PROPERTIES:")
    (replace-match "+++")
    (beginning-of-line)
    (fixup-whitespace)
    (re-search-forward ":filename: ")
    (beginning-of-line)
    (kill-line)
    (insert-string (format "title = \"%s\"\n" title))
    (insert-string (format "weight = %d" index))
    (re-search-forward ":END:")
    (replace-match "+++")
    (beginning-of-line)
    (fixup-whitespace)
    ;; Subsections were pasted as level 2. Shift them to level 1.
    (org-map-entries '(org-promote))
    (save-buffer)
    ;; (kill-buffer)
    (setq buffers-to-delete (cons (current-buffer) buffers-to-delete))
    )

  (provide '031_org-split-hugo)
  ;;; 031_org-split-hugo.el ends here
(provide 'org-split-hugo)
;;; 017_org-split-hugo.el ends here
