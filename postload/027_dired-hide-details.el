;;; dired-hide-details --- 2017-11-01 11:21:19 πμ
;;; Commentary:
;; HIDE DETAILS WHEN FIRST OPENING DIRED

;; Note: following does not work. Why?
;; (setq dired-hide-details-mode t)

;; Using dired+ opens dired without details per default

;;; Code:

(prelude-load-require-package 'dired+)
(provide 'dired-hide-details)
;;; 027_dired-hide-details.el ends here
