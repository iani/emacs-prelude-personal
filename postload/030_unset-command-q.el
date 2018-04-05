;;; unset-command-q --- 2018-04-05 04:37:59 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 030_unset-command-q.el ends here
