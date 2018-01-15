;;; calc-time-zones --- 2018-01-15 01:38:41 μμ
;;; Commentary:
;; Add some useful time zones
(require 'calc-forms) ;; built-in package
(add-to-list 'math-tzone-names '("JST" 9 0))
(add-to-list 'math-tzone-names '("EEST" 3 0))
(provide 'calc-time-zones)
;;; 019_calc-time-zones.el ends here
