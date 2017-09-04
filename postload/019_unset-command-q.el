;;; unset-command-q --- 2017-09-04 09:48:11 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 019_unset-command-q.el ends here
