;;; unset-command-q --- 2017-12-22 01:59:34 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 027_unset-command-q.el ends here
