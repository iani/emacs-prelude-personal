;;; unset-command-q --- 2019-03-05 07:02:45 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 033_unset-command-q.el ends here
