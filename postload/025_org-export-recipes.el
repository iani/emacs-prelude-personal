;;; org-export-recipes --- 2018-02-28 04:14:13 PM
;;; Commentary:

;; define concenience function for selecting a recipe file
;; from this folder and insering it in the org file to configure export.

;;; Code:

;; (prelude-load-require-package 'helm)

(require 'helm)

(defconst org-export-recipe-folder (concat
                                    (file-name-directory load-file-name)
                                    "/recipes/"))

(defconst org-export-snippet-folder (concat
                                    (file-name-directory load-file-name)
                                    "/snippets/"))

(defconst org-lisp-snippet-folder (concat
                                     (file-name-directory load-file-name)
                                     "/elisp-snippets/"))

(defun org-export-insert-recipe (snippet-p)
  "Select and insert file from recipes or snippet to org-mode file.
If SNIPPET-P then insert snippet from snippet folder in text at point.
Else insert recipe from recipe folder at top of file."
  (interactive "P")
  (if snippet-p
      (insert-file-contents
       (helm-read-file-name "select snippet:" :initial-input org-export-snippet-folder))
    (save-excursion
      (goto-char 0)
      (insert-file-contents  (helm-read-file-name "select recipe:" :initial-input org-export-recipe-folder)))))

(defun org-load-lisp-snippet (open-p)
  "Load or edit file from elisp-snippets folder.
If OPEN-P then open snippet for editing instead of loading it.
Else insert recipe from recipe folder at top of file."
  (interactive "P")
  (if open-p
      (find-file
     (helm-read-file-name "edit snippet:" :initial-input org-lisp-snippet-folder))
    (load
       (helm-read-file-name "load snippet:" :initial-input org-lisp-snippet-folder))))

(global-set-key (kbd "H-c i") 'org-export-insert-recipe)
(global-set-key (kbd "H-c l") 'org-load-lisp-snippet)
(provide 'org-export-recipes)
;;; 025_org-export-recipes.el ends here
