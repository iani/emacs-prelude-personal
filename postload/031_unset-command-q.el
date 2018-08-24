;;; unset-command-q --- 2018-08-24 12:06:33 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 031_unset-command-q.el ends here
