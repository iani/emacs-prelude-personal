;;; unset-command-q --- 2019-01-29 03:48:05 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 033_unset-command-q.el ends here
