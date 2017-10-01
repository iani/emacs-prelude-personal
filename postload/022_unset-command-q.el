;;; unset-command-q --- 2017-10-01 01:03:14 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 022_unset-command-q.el ends here
