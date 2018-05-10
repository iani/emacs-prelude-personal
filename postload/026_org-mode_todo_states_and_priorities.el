;;; org-mode_todo_states_and_priorities --- 2018-05-08 10:56:26 PM
  (setq org-todo-keywords
         '((sequence "TODO(t)" "|" "DONE(d@)" "CANCELED(c@)")))
  (setq org-lowest-priority 77) ;; Set possible priorities range from A to M
  (setq org-default-priority 77) ;; List TODOS without priority setting at the bottom
(provide 'org-mode_todo_states_and_priorities)
;;; 026_org-mode_todo_states_and_priorities.el ends here
