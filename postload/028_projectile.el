;;; projectile --- 2017-12-22 01:59:34 AM
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
;;; 028_projectile.el ends here
