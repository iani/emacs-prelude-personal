;;; org-mode_todo_states_and_priorities --- 2019-01-23 04:39:40 AM
  ;; Experimental, 29 Sep 2018 04:25
  ;; after https://orgmode.org/manual/Fast-access-to-TODO-states.html#Fast-access-to-TODO-states

  ;; Example of more elaborate todo keywords
  ;; (setq org-todo-keywords
  ;;       '((sequence "TODO(t)" "|" "DONE(d)")
  ;;         (sequence "REPORT(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
  ;;         (sequence "|" "CANCELED(c)")))

  ;; Example of custom colors for keywords
  ;; (setq org-todo-keyword-faces
  ;;       '(("TODO" . (:foreground "#ff39a3" :weight bold))
  ;;         ("STARTED" . "#E35DBF")
  ;;         ("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
  ;;         ("DELEGATED" . "pink")
  ;;         ("POSTPONED" . "#008080")))
  ;;

  (setq org-todo-keywords
        '((sequence "TODO(t)" "|" "TAZE(z)" "|" "STARTED(s@)" "|" "BAYAT(b)" "|" "DONE(d@)")
          (sequence "|" "URGENT(u)")
          (sequence "|" "DELEGATED(l)")
          (sequence "|" "CANCELED(c)")
          (sequence "|" "POSTPONED(p)")))

  (setq org-todo-keyword-faces
        '(("TODO" . (:foreground "red1" :weight bold))
          ("TAZE" . (:foreground "green3" :background "navy" :weight bold))
          ("URGENT" . (:foreground "red1" :background "orange1" :weight bold))
          ("STARTED" . (:foreground "salmon" :weight bold))
          ;; ("STARTED" . "#E35DBF")
          ("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
          ("DELEGATED" . (:foreground "orange2" :background "#4d4d4d" :weight bold))
          ("POSTPONED" . (:foreground "dark cyan" :weight bold))
          ("BAYAT" . (:foreground "gainsboro" :weight bold))
          ;; ("POSTPONED" . "#008080")
          ))


  (setq org-lowest-priority 77) ;; Set possible priorities range from A to M
  (setq org-default-priority 77) ;; List TODOS without priority setting at the bottom
(provide 'org-mode_todo_states_and_priorities)
;;; 028_org-mode_todo_states_and_priorities.el ends here
