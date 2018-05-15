;;; unset-command-q --- 2018-05-15 08:58:57 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 030_unset-command-q.el ends here
