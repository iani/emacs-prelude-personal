;;; unset-command-q --- 2017-10-12 10:56:25 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 023_unset-command-q.el ends here
