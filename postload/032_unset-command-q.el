;;; unset-command-q --- 2018-11-13 12:50:30 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 032_unset-command-q.el ends here
