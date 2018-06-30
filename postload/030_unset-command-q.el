;;; unset-command-q --- 2018-06-30 10:14:49 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 030_unset-command-q.el ends here
