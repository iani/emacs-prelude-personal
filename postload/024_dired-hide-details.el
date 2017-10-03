;;; dired-hide-details --- 2017-10-03 10:57:26 AM
  ;;; Commentary:
  ;; HIDE DETAILS WHEN FIRST OPENING DIRED

  ;; Note: following does not work. Why?
  ;; (setq dired-hide-details-mode t)

  ;; Using dired+ opens dired without details per default

  ;;; Code:

  (prelude-load-require-package 'dired+)
(provide 'dired-hide-details)
;;; 024_dired-hide-details.el ends here
