;;; unset-command-q --- 2018-09-20 11:34:50 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 031_unset-command-q.el ends here
