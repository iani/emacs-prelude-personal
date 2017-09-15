;;; unset-command-q --- 2017-09-15 08:57:24 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 020_unset-command-q.el ends here
