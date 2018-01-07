;;; unset-command-q --- 2018-01-07 01:19:05 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 026_unset-command-q.el ends here
