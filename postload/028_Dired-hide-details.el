;;; Dired-hide-details --- 2018-01-15 01:38:42 μμ
;;; Commentary:
;; HIDE DETAILS WHEN FIRST OPENING DIRED

;; Note: following does not work. Why?
;; (setq dired-hide-details-mode t)

;; Using dired+ opens dired without details per default

;;; Code:

(prelude-load-require-package 'dired+)
(provide 'Dired-hide-details)
;;; 028_Dired-hide-details.el ends here
