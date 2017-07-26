;;; projectile --- 2017-07-26 02:15:58 PM
  ;;; Commentary:
  ;;; some useful extensions to projectile
  ;;; helm-projectile, helm-perspective

  ;;; Code:
;; (prelude-load-require-packages '(perspective helm-projectile persp-projectile))
(prelude-load-require-packages '(helm-projectile))
  (helm-projectile-on)
  (setq projectile-switch-project-action #'projectile-commander)
  ;; (persp-mode)
  ;; (require 'persp-projectile)
  ;; (define-key projectile-mode-map (kbd "s-s") 'projectile-persp-switch-project)
(provide 'projectile)
;;; 019_projectile.el ends here
