;;; projectile --- 2017-11-01 11:21:19 πμ
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
;;; 026_projectile.el ends here
