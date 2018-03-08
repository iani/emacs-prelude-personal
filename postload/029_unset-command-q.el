;;; unset-command-q --- 2018-03-08 09:32:23 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 029_unset-command-q.el ends here
