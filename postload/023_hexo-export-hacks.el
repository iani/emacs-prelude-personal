
;; Convert sclang source code regions to javascript when saving
;; This makes the hexo org-mode plugin htmlize those regions acceptably.
;; Otherwise, no coloring, and > characters are converted to html-entities

(defun org-sclang2js ()
  "Convert scr regions from sclang to javascript."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward  "\\#\\+BEGIN_SRC sclang" nil t)
      (replace-match "\#\+BEGIN_SRC javascript"))))

(defun org-js2sclang ()
  "Convert scr regions from sclang to javascript."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\#\\+BEGIN_SRC javascript" nil t)
      (replace-match "\#\+BEGIN_SRC sclang"))))

(global-set-key (kbd "H-c H-s") 'org-js2sclang)
(global-set-key (kbd "H-c H-j") 'org-sclang2js)


