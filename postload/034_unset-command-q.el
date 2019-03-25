;;; unset-command-q --- 2019-03-24 06:03:24 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 034_unset-command-q.el ends here
