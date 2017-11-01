;;; unset-command-q --- 2017-11-01 11:21:19 πμ
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 025_unset-command-q.el ends here
