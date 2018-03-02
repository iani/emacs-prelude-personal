;;; calc-time-zones --- 2018-03-02 06:19:40 PM
;;; Commentary:
;; Add some useful time zones
(require 'calc-forms) ;; built-in package
(add-to-list 'math-tzone-names '("JST" 9 0))
(add-to-list 'math-tzone-names '("EEST" 3 0))
(provide 'calc-time-zones)
;;; 020_calc-time-zones.el ends here
