(toggle-frame-fullscreen)
;; (desktop-read)
;; (dired "~/Copy/000WORKFILES")
;; (deft-here "~/Copy/000WORKFILES/1_NOTES")
;; (sr-speedbar-open)
;; (speedbar-workfiles)
;; (find-file (concat iz-log-dir "PERSONAL/DIARY.org"))
;; (org-agenda-here '(4))
;; (org-agenda-toggle-diary)

;; (setq org-agenda-files
;;       (list
;;        (concat iz-log-dir "PERSONAL/DIARY.org")
;;        (concat iz-log-dir "PERSONAL/TODOS/TODOS.org")))

;; (org-log-here (car org-agenda-files) t)

;; (run-at-time "5 sec" nil
;;              (lambda ()
;;                (org-agenda nil "a")
;;                (org-agenda-toggle-diary)
;;                ;; (let ((org-agenda-multi t))
;;                ;;   (org-agenda nil "t")
;;                ;;   (widen)
;;                ;;   (org-agenda-finalize)
;;                ;;   (setq buffer-read-only t)
;;                ;;   (org-agenda-fit-window-to-buffer))
;;                (delete-other-windows)
;;                (split-window-right)
;;                (org-agenda nil "t")
;;                ))

;; (run-at-time "2 sec" nil (lambda () (org-calfw-here)))
