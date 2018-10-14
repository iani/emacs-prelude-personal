;;; unset-command-q --- 2018-10-14 10:40:33 AM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 035_unset-command-q.el ends here
