;;; unset-command-q --- 2017-08-13 08:59:57 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 018_unset-command-q.el ends here
