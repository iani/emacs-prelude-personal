;;; unset-command-q --- 2018-10-01 01:16:18 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 035_unset-command-q.el ends here
