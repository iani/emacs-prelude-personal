;;; projectile-find-file_workfiles --- 2018-01-04 10:39:31 AM
  (defun projectile-find-file-workfiles ()
      "Set current project to workfiles and Find file in projectile."
    (interactive)
      (let ((projectile-project-root (file-truename "~/BitTorrent Sync/000WORKFILES")))
     (helm-projectile-find-file)))

  (global-set-key (kbd "C-M-S-f") 'projectile-find-file-workfiles)
(provide 'projectile-find-file_workfiles)
;;; 023_projectile-find-file_workfiles.el ends here
