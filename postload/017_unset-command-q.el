;;; unset-command-q --- 2017-08-22 09:22:54 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 017_unset-command-q.el ends here
