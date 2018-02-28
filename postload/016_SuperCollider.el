;;; SuperCollider --- 2018-02-28 04:14:10 PM
;;; Commentary:
;; Basic setup for using SuperCollider in EMACS

;; (add-to-list 'load-path "~/.emacs.d/personal/packages/sclang/")
;; (load-file "~/.emacs.d/personal/packages/sclang/sclang.el")
;; (load-file "~/.emacs.d/personal/packages/sc-snippets/sc-snippets.el")
(require 'sclang) ;; must be made available through links in personal/packages
;; (require 'sc-snippets) ;; replaced by postload file

;;; Directory of SuperCollider support, for quarks, plugins, help etc.
(defvar sc_userAppSupportDir
  (expand-file-name "~/Library/Application Support/SuperCollider"))

;; Make path of sclang executable available to emacs shell load path

;; For Version 3.6.6:
(add-to-list
 'exec-path
 "/Applications/SuperCollider/SuperCollider.app/Contents/Resources/")

;; For Version 3.7:
(add-to-list
 'exec-path
 "/Applications/SuperCollider/SuperCollider.app/Contents/MacOS/")

;; Global keyboard shortcut for starting sclang
(global-set-key (kbd "C-c M-s") 'sclang-start)
;; overrides alt-meta switch command
(global-set-key (kbd "C-c W") 'sclang-switch-to-workspace)

(provide 'SuperCollider)
;;; 016_SuperCollider.el ends here
