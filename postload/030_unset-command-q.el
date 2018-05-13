;;; unset-command-q --- 2018-05-13 11:43:27 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 030_unset-command-q.el ends here
