;;; unset-command-q --- 2017-10-06 09:25:42 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 022_unset-command-q.el ends here
