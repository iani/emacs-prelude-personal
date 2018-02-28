;;; org-split-hugo --- 2018-02-28 04:14:12 PM
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
;;; The foldername property sets the component of the folder path
;;; in the corresponding depth of subsections in a list of path components.
;;; Construct _index.md from the name of the folder section.
;;; Increment a folder_index variable to set weight for folder _index.md.

;;; Code:

;;; provides commands for hugo config, page creation, publish and
(prelude-load-require-packages '(easy-hugo dash)) ;; dash list utility functions

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
             (org-hugo-export)
             ;; (message "hugo export to individual files done")
             )
           'append 'local)
 (message "This buffer will now export to hugo section files after each save."))

(defun org-hugo-export ()
  "Split 1st level sections with filename property to files.
Add front-matter for hugo, including automatic weights."
  (interactive)
  (let*
      ((root-dir (file-name-directory (buffer-file-name)))
       (cleanup-list (file-expand-wildcards (concat root-dir "*")))
       (path root-dir)
       (folder-components)
       (index 0)
       folderindex ;; initialized from index upon first folder
       buffers-to-delete)
    (mapc
     (lambda (path)
       (if
           (file-directory-p path)
           (delete-directory path t))
       (if (string-match-p
            "[[:digit:]]+-"
            (file-name-nondirectory path))
           (delete-file path)))
     cleanup-list)
    (org-map-entries
     '(org-split-1-file-or-folder)
     t 'file 'archive 'comment)
    (mapc (lambda (buffer)
            ;; (message "killing buffer: %s" buffer)
            (set-buffer-modified-p nil)
            (kill-buffer buffer))
          buffers-to-delete)
    (message "Exported %d files" index)))

(defun org-split-1-file-or-folder ()
  "Helper function for org-hugo-export.
First compute the path based on levels and previous input.
Then export the file using the path.
Files are automatically stored in nested folders corresponding
to the level of the section that is the source of the file.
The path for the nested folders is stored in variable FOLDER-COMPONENTS.
Level 1 corresponds to root level of the base folder path.
Therefore for level 1 the string to add to the folder path is the
empty string \"\".
Level 2 has default contents (\"section1/\"), Etc.
The default names section1, section2 etc. can be overwritten
by setting the property foldername of any section.
This overwrites the foldername at the corresponding level position
in the FOLDER-COMPONENTS list."
  (let*
      ((filename (org-entry-get (point) "filename"))
       (foldername (org-entry-get (point) "foldername"))
       (element (cadr (org-element-at-point)))
       (title (plist-get element :title))
       (level (plist-get element :level))
       contents
       ;; (num-folders (- level 1))
       )
    ;; (message "PREPARING TOPLEVEL EXPORT OF: %s" filename)
    (when (or foldername filename)
      (setq index (+ 1 index))
      ;; add missing default levels to folder-components list
      (when(< (length folder-components) level)
        (setq folder-components
              (append folder-components
                      (--map (list (format "section%d/" it) (format "section%d/" it))
                             (-iterate '1+ level (- level (length folder-components))))))))
    (when foldername ;; set folder name at corresponding level of folder-components
        (setq folder-components
              (-replace-at (1- level)
                           (list (concat foldername "/") title)
                           folder-components)))
    (when filename
      ;; (message "the filename is: %s" filename)
      (setq contents (buffer-substring
                      (plist-get element :contents-begin)
                      (plist-get element :contents-end)))
      (org-hugo-make-folders)
      (org-hugo-export-section-2-file))))

(defun org-hugo-make-folders ()
  "Make subfolders for this level and provide index file for each."
  (when (> level 1)
    ;; (message "testing %s" folder-components)
    (let
        ((sub-components (-take (1- level) folder-components))
         (dir root-dir))
      (make-directory (concat
                       root-dir
                       (apply 'concat (-map 'car sub-components)))
                      t)
      (-each
          sub-components
        (lambda (component)
          (setq dir (concat dir (car component)))
          (let
              ((section-name (cadr component))
               (header-file (concat dir "_index.md")))
            (find-file header-file)
            (erase-buffer)
            (insert (format "+++\ntitle = \"%s\"\nweight = %d\n+++\n\n"
                            section-name index))
            (insert "__See next page ->__\n")

            (save-buffer)
            (kill-buffer)))))))

(defun org-hugo-export-section-2-file ()
  "Export current \"org-mode\" section to org-mode file.
Add yaml header for hugo."
  ;; (message "EXPORTING!!! filename: %s, level: %d, foldername: %s, components: %s"
  ;;          filename level foldername folder-components)
  ;; (message "subfolderpath: %s"
  ;;          (apply 'concat (-take (1- level) (-map 'car folder-components))))
  ;; (message "full path: %s"
  ;;          (concat
  ;;           root-dir
  ;;           (apply 'concat (-take (1- level) (-map 'car folder-components)))
  ;;           filename ".org"))
  ;; (goto-char (plist-get element :begin))
  ;; (org-copy-subtree)
  (find-file (format "%s%03d-%s.org"
                     (concat
                      root-dir
                      (apply 'concat (-take (1- level) (-map 'car folder-components)))
                      )
                     index filename))
  (erase-buffer)
  ;; (message "I am now in buffer: %s" (current-buffer))
  (insert contents)
  (goto-char (point-min))
  (re-search-forward ":END:")
  (kill-region (point-min) (point))
  (insert
   (format "+++\ntitle = \"%s\"\nweight = %d\n+++" title index))
  (-dotimes level (lambda (n) (org-map-entries 'org-promote)))
  (save-buffer)
  (setq buffers-to-delete (cons (current-buffer) buffers-to-delete)))

(defun org-hugo-select-filenames ()
  "Build sparse tree with entries whose property filename is set."
  (interactive)
  (org-match-sparse-tree nil "filename={[^§]}"))

(eval-after-load 'org
  '(progn
     (define-key org-mode-map (kbd "C-c C-h C-e") 'org-hugo-export)
     (define-key org-mode-map (kbd "C-c C-h C-a") 'org-hugo-autosplit)
     (define-key org-mode-map (kbd "C-c C-h C-/") 'org-hugo-select-filenames)))
(provide 'org-split-hugo)
;;; 024_org-split-hugo.el ends here
