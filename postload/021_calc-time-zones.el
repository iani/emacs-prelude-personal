;;; calc-time-zones --- 2018-05-08 10:56:25 PM
  ;;; Commentary:
  ;; Add some useful time zones
  (require 'calc-forms) ;; built-in package
  (add-to-list 'math-tzone-names '("JST" 9 0))
  (add-to-list 'math-tzone-names '("EEST" 3 0))
(provide 'calc-time-zones)
;;; 021_calc-time-zones.el ends here
