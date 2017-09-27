;;; unset-command-q --- 2017-09-27 10:23:52 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 021_unset-command-q.el ends here
