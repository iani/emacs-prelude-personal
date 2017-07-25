;;; org-mode --- 2017-07-25 09:12:43 PM

;;; Commentary:

;; customize some org mode settings
;; define some useful functions

;;; Code:

;; load util to insert recipes for export customization:
(require 'org-export-recipes)

(setq org-attach-directory (file-truename "~/Documents/org-attachments/"))
(setq org-agenda-sticky t) ;; open agenda and todo views in separate buffers
;; (setq org-agenda-diary-file (file-truename
;;                              (concat iz-log-dir "PERSONAL/DIARY2.txt")))

;; customize looks
(custom-set-faces
 '(org-block-end-line ((t (:background "#3a3a3a" :foreground "gray99"))) t)
 '(org-level-1 ((t (:weight bold :height 1.1))))
 '(org-level-2 ((t (:weight bold :height 1.1))))
 '(org-level-3 ((t (:weight bold :height 1.1))))
 '(org-level-4 ((t (:weight bold :height 1.1))))
 '(org-level-5 ((t (:weight bold :height 1.1))))
 '(org-level-6 ((t (:weight bold :height 1.1))))
 '(org-level-7 ((t (:weight bold :height 1.1))))
 '(org-level-8 ((t (:weight bold :height 1.1))))
 '(org-level-9 ((t (:weight bold :height 1.1)))))

(defun org-set-date (&optional active property)
  "Set DATE property with current time.  Active timestamp."
  (interactive "P")
  (org-set-property
   (if property property "DATE")
   (cond ((equal active nil)
          (format-time-string (cdr org-time-stamp-formats) (current-time)))
         ((equal active '(4))
          (concat "["
                  (substring
                   (format-time-string (cdr org-time-stamp-formats) (current-time))
                   1 -1)
                  "]"))
         ((equal active '(16))
          (concat
           "["
           (substring
            (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))
            1 -1)
           "]"))
         ((equal active '(64))
          (format-time-string (cdr org-time-stamp-formats) (org-read-date t t))))))

(defun org-insert-current-date (arg)
  "Insert current date in format readable for org-capture minibuffer.
If called with ARG, do not insert time."
  (interactive "P")
  (if arg
      (insert (format-time-string "%e %b %Y"))
    (insert (format-time-string "%e %b %Y %H:%M"))))

(eval-after-load 'org
  '(progn
     ;; Note: This keybinding is in analogy to the default keybinding:
     ;; C-c . -> org-time-stamp
     (define-key org-mode-map (kbd "C-c C-.") 'org-set-date)
     (define-key org-mode-map (kbd "C-M-{") 'backward-paragraph)
     (define-key org-mode-map (kbd "C-M-}") 'forward-paragraph)))

(global-set-key (kbd "C-c C-x t") 'org-insert-current-date)
(provide 'org-mode)
;;; 015_org-mode.el ends here
