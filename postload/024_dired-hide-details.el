;;; dired-hide-details --- 2017-10-01 01:03:15 PM
  ;;; Commentary:
  ;; HIDE DETAILS WHEN FIRST OPENING DIRED

  ;; Note: following does not work. Why?
  ;; (setq dired-hide-details-mode t)

  ;; Using dired+ opens dired without details per default

  ;;; Code:

  (prelude-load-require-package 'dired+)
(provide 'dired-hide-details)
;;; 024_dired-hide-details.el ends here
