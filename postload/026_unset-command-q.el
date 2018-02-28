;;; unset-command-q --- 2018-02-28 10:59:00 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 026_unset-command-q.el ends here
