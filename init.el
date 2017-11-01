;;; package --- Load configuration files.

;;; Commentary:

;;; Code:

;;; Add load paths for all packages in personal/packages.
(mapc (lambda (path)
        (add-to-list 'load-path (concat path "/")))
      (file-expand-wildcards "~/.emacs.d/personal/packages/*"))

;;; Load all customization files in alphabetical order.
(mapcar (lambda (path)
          (load-file path))
        (file-expand-wildcards "~/.emacs.d/personal/postload/*.el"))

(provide 'init.el)
;;; init.el ends here
