;;; unset-command-q --- 2017-10-12 04:23:11 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 023_unset-command-q.el ends here
