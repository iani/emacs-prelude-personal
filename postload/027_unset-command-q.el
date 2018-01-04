;;; unset-command-q --- 2018-01-04 10:39:32 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 027_unset-command-q.el ends here
