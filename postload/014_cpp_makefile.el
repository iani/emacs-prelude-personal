;;; cpp_makefile --- 2018-11-03 03:10:54 PM
;;; Gcc and makefile support

;; G++ code here

 (global-set-key "\C-xc" 'compile)
 (setq make-backup-files 'nil)
 ;;(setq default-major-mode 'text-mode)
 (setq text-mode-hook 'turn-on-auto-fill)
 ;;(set-default-font "-misc-fixed-medium-r-normal--15-140-*-*-c-*-*-1")
 (setq auto-mode-alist (cons '("\\.cxx$" . c++-mode) auto-mode-alist))
 (setq auto-mode-alist (cons '("\\.hpp$" . c++-mode) auto-mode-alist))
 (setq auto-mode-alist (cons '("\\.tex$" . latex-mode) auto-mode-alist))

;;(require 'font-lock)
;;(add-hook 'c-mode-hook 'turn-on-font-lock)
;;(add-hook 'c++-mode-hook 'turn-on-font-lock)

(provide 'cpp_makefile)
;;; 014_cpp_makefile.el ends here
