;;; dired-hide-details --- 2017-09-09 01:52:50 PM
  ;;; Commentary:
  ;; HIDE DETAILS WHEN FIRST OPENING DIRED

  ;; Note: following does not work. Why?
  ;; (setq dired-hide-details-mode t)

  ;; Using dired+ opens dired without details per default

  ;;; Code:

  (prelude-load-require-package 'dired+)
(provide 'dired-hide-details)
;;; 021_dired-hide-details.el ends here
