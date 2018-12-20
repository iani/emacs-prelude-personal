;;; unset-command-q --- 2018-12-20 06:11:42 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 032_unset-command-q.el ends here
