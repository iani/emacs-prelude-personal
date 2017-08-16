;;; packages --- 2017-08-16 10:20:36 AM

  ;;; Commentary:
  ;;; this is only some of the packags.
  ;;; Some other required packages are loaded in the following postload files.
  ;;; using prelude-require-package ensures that the packges are loaded
  ;;; at the time required, if necessary.

  ;;; Code:

  (require 'prelude-packages)

  ;; also load prelude-required packages manually.
  ;; this loads packages which are not (auto-) loaded otherwise.
  ;; apparently prelude-required packages will be available after restarting emacs twice ...
  (defun prelude-load-require-package (package)
    "Install PACKAGE unless already installed."
    (unless (memq package prelude-packages)
      (add-to-list 'prelude-packages package))
    (unless (package-installed-p package)
      (package-install package))
    (require package))

  (defun prelude-load-require-packages (packages)
    "Ensure PACKAGES are installed.
  Missing packages are installed automatically."
    (mapc #'prelude-load-require-package packages))

  (prelude-load-require-packages
   '(
     moe-theme
     powerline
     multi-term))

(provide 'packages)
;;; 001_packages.el ends here
