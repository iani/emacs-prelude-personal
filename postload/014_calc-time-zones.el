;;; calc-time-zones --- 2017-09-05 08:46:52 AM
  ;;; Commentary:
  ;; Add some useful time zones
  (require 'calc-forms) ;; built-in package
  (add-to-list 'math-tzone-names '("JST" 9 0))
  (add-to-list 'math-tzone-names '("EEST" 3 0))
(provide 'calc-time-zones)
;;; 014_calc-time-zones.el ends here
