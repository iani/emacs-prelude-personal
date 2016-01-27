;;; package --- Load configuration files.

;;; Commentary:

;;; Code:

;; (org-babel-load-file "~/.emacs.d/personal/postload/init.org")

;; (mapcar (lambda (path) (load-file path))
;;        (directory-files "~/.emacs.d/personal/postload/" nil ".el$"))

;; (load-file "/Users/iani/.emacs.d/personal/000_EnableFullscreen.el")

(mapcar (lambda (path)
          (load-file path))
        (file-expand-wildcards "~/.emacs.d/personal/postload/*.el"))

(provide 'init.el)
;;; init.el ends here
