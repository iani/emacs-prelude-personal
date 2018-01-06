;;; projectile-find-file_workfiles --- 2018-01-05 11:08:11 PM
  (defun projectile-find-file-workfiles ()
      "Set current project to workfiles and Find file in projectile."
    (interactive)
      (let ((projectile-project-root (file-truename "~/BitTorrent Sync/000WORKFILES")))
        (helm-projectile-find-file)))

  (defun projectile-commander-workfiles ()
    "Set current project to workfiles and call projectile-commander."
    (interactive)
    (let ((projectile-project-root (file-truename "~/BitTorrent Sync/000WORKFILES")))
      (projectile-commander)))

  (global-set-key (kbd "C-M-S-f") 'projectile-find-file-workfiles)
(provide 'projectile-find-file_workfiles)
;;; 023_projectile-find-file_workfiles.el ends here
