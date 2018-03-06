;;; unset-command-q --- 2018-03-06 03:07:36 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 029_unset-command-q.el ends here
