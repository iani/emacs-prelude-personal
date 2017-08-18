;;; org-mode --- 2017-08-19 03:34:53 AM

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

  ;; This is run once after loading org for the first time
  ;; It adds some org-mode specific key bindings.
  (eval-after-load 'org
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key org-mode-map (kbd "C-c C-.") 'org-set-date)
       (define-key org-mode-map (kbd "C-M-{") 'backward-paragraph)
       (define-key org-mode-map (kbd "C-M-}") 'forward-paragraph)
       (define-key org-mode-map (kbd "C-c C-S") 'org-schedule)
       (define-key org-mode-map (kbd "C-c C-s") 'sclang-main-stop)
       (define-key org-mode-map (kbd "C-c >") 'sclang-show-post-buffer)
       ;; own additions after org-config-examples below:
       (define-key org-mode-map (kbd "C-M-f") 'org-forward-heading-same-level)
       (define-key org-mode-map (kbd "C-M-b") 'org-backward-heading-same-level)
       (define-key org-mode-map (kbd "C-M-u") 'outline-up-heading)
       (define-key org-mode-map (kbd "C-M-n") 'org-next-src-block)
       (define-key org-mode-map (kbd "C-M-p") 'org-show-properties-block)
       (define-key org-mode-map (kbd "C-M-/") 'org-sclang-eval-babel-block)
          ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       ;; from: http://orgmode.org/worg/org-configs/org-config-examples.html
       ;; section navigation
       (define-key org-mode-map (kbd "M-n") 'outline-next-visible-heading)
       (define-key org-mode-map (kbd "M-p") 'outline-previous-visible-heading)
       ;; table
       (define-key org-mode-map (kbd "C-M-w") 'org-table-copy-region)
       (define-key org-mode-map (kbd "C-M-y") 'org-table-paste-rectangle)
       (define-key org-mode-map (kbd "C-M-l") 'org-table-sort-lines)
       ;; display images
       (define-key org-mode-map (kbd "M-I") 'org-toggle-iimage-in-org)
       ))

  (defun org-next-src-block ()
    "Jump to the next src block using SEARCH-FORWARD."
    (interactive)
    (search-forward "\n#+BEGIN_SRC")
    (let ((block-beginning (point)))
      (org-show-entry)
      (goto-char block-beginning)
      (goto-char (line-end-position 2))))

  (defun org-show-properties-block ()
    "Show the entire next properties block using SEARCH-FORWARD."
    (interactive)
    (search-forward ":PROPERTIES:")
    (let ((block-beginning (point)))
      (org-show-entry)
      (goto-char block-beginning)
      (org-cycle)
      ;; (goto-char (line-end-position 2))
      ;; (org-hide-block-toggle t)
      ))

  ;; org-mode-hook is run every time that org-mode is turned on for a buffer
  ;; It customizes some settings in the mode.
  (add-hook
   'org-mode-hook 
   (lambda ()
     ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
     ;; own stuff:
     ;; Make javascript blocks open in sclang mode in org-edit-special
     ;; This is because sclang blocks must currently be marked as javascript
     ;; in order to render properly with hugo / pygments for webite creation.
     (setq org-src-lang-modes (add-to-list 'org-src-lang-modes '("javascript" . sclang)))
     (setq org-hide-leading-stars t)
     ;; (org-indent-mode) ;; this results in added leading spaces in org-edit-special
     (visual-line-mode)))

  (defun org-customize-mode ()
    "Customize some display options for ORG-MODE.
  - map javascript to sclang-mode in babel blocks.
  - hide extra leading stars for sections.
  - turn on visual line mode."
  )

  (global-set-key (kbd "C-c C-x t") 'org-insert-current-date)
(provide 'org-mode)
;;; 015_org-mode.el ends here
