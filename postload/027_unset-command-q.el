;;; unset-command-q --- 2018-03-02 06:19:41 PM
;;; Commentary:
;;; disable command-q key to avoid inadvertently quitting EMACS.

;;; Code:
(global-set-key (kbd "s-q") nil)
(provide 'unset-command-q)
;;; 027_unset-command-q.el ends here
