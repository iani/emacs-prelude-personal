;;; projectile --- 2018-03-02 06:19:42 PM
;;; Commentary:
;;; some useful extensions to projectile
;;; helm-projectile
;;; Note: neither perspective nor helm-perspective work for me.

;;; Code:
;; (prelude-load-require-packages '(perspective helm-projectile persp-projectile))
(prelude-load-require-packages '(helm-projectile))
(helm-projectile-on)
(setq projectile-switch-project-action #'projectile-commander)
;; (persp-mode)
;; (require 'persp-projectile)
;; (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
(provide 'projectile)
;;; 030_projectile.el ends here
