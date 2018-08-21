;;; org-mode_todo_states_and_priorities --- 2018-08-22 08:58:10 AM
  (setq org-todo-keywords
         '((sequence "TODO(t)" "|" "DONE(d@)" "CANCELED(c@)")))
  (setq org-lowest-priority 77) ;; Set possible priorities range from A to M
  (setq org-default-priority 77) ;; List TODOS without priority setting at the bottom
(provide 'org-mode_todo_states_and_priorities)
;;; 027_org-mode_todo_states_and_priorities.el ends here
