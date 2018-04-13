;;; unset-command-q --- 2018-04-13 10:13:29 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 031_unset-command-q.el ends here
