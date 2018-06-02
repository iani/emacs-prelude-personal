;;; projectile --- 2018-06-02 09:10:40 AM
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
;;; 032_projectile.el ends here
