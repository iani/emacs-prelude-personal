;;; unset-command-q --- 2017-11-02 11:01:29 πμ
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 024_unset-command-q.el ends here
