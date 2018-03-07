;;; Dired-hide-details --- 2018-03-07 08:52:49 PM
  ;;; Commentary:
  ;; HIDE DETAILS WHEN FIRST OPENING DIRED

  ;; Note: following does not work. Why?
  ;; (setq dired-hide-details-mode t)

  ;; Using dired+ opens dired without details per default

  ;;; Code:

  (prelude-load-require-package 'dired+)
(provide 'Dired-hide-details)
;;; 031_Dired-hide-details.el ends here
