;;; unset-command-q --- 2017-12-15 09:58:38 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 025_unset-command-q.el ends here
