;;; Dired-hide-details --- 2018-01-08 11:14:50 AM
  ;;; Commentary:
  ;; HIDE DETAILS WHEN FIRST OPENING DIRED

  ;; Note: following does not work. Why?
  ;; (setq dired-hide-details-mode t)

  ;; Using dired+ opens dired without details per default

  ;;; Code:

  (prelude-load-require-package 'dired+)
(provide 'Dired-hide-details)
;;; 028_Dired-hide-details.el ends here
