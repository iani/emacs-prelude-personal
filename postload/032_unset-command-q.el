;;; unset-command-q --- 2018-11-13 02:38:14 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 032_unset-command-q.el ends here
