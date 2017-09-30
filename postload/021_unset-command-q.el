;;; unset-command-q --- 2017-09-29 11:26:05 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 021_unset-command-q.el ends here
