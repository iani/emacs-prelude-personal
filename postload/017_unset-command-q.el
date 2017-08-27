;;; unset-command-q --- 2017-08-27 06:35:50 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 017_unset-command-q.el ends here
