;;; unset-command-q --- 2017-08-17 08:42:32 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 018_unset-command-q.el ends here
