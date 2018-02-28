;;; calc-time-zones --- 2018-02-28 04:14:11 PM
;;; Commentary:
;; Add some useful time zones
(require 'calc-forms) ;; built-in package
(add-to-list 'math-tzone-names '("JST" 9 0))
(add-to-list 'math-tzone-names '("EEST" 3 0))
(provide 'calc-time-zones)
;;; 019_calc-time-zones.el ends here
