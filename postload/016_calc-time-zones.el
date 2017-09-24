;;; calc-time-zones --- 2017-09-24 11:37:43 PM
  ;;; Commentary:
  ;; Add some useful time zones
  (require 'calc-forms) ;; built-in package
  (add-to-list 'math-tzone-names '("JST" 9 0))
  (add-to-list 'math-tzone-names '("EEST" 3 0))
(provide 'calc-time-zones)
;;; 016_calc-time-zones.el ends here
