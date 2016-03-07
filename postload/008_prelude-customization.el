(setq prelude-whitespace nil)

;; undo prelude keybindings which interfere with org-mode
(setq prelude-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c o") 'prelude-open-with)
    (define-key map (kbd "C-c g") 'prelude-google)
    (define-key map (kbd "C-c G") 'prelude-github)
    (define-key map (kbd "C-c y") 'prelude-youtube)
    (define-key map (kbd "C-c U") 'prelude-duckduckgo)
    ;; mimic popular IDEs binding, note that it doesn't work in a terminal session
    (define-key map [(shift return)] 'prelude-smart-open-line)
    (define-key map (kbd "M-o") 'prelude-smart-open-line)
    (define-key map [(control shift return)] 'prelude-smart-open-line-above)
    (define-key map [(control shift up)]  'move-text-up)
    (define-key map [(control shift down)]  'move-text-down)
    ;; the following 2 break structure editing with meta-shift-up / down in org mode
    ;;    (define-key map [(meta shift up)]  'move-text-up)
    ;;    (define-key map [(meta shift down)]  'move-text-down)
    ;; new substitutes for above:
    ;; (define-key map (kbd "C-c [")  'move-text-up)
    ;; (define-key map (kbd "C-c ]")  'move-text-down)
    ;; (define-key map [(control meta shift up)]  'move-text-up)
    ;; (define-key map [(control meta shift down)]  'move-text-down)
    (define-key map (kbd "C-c n") 'prelude-cleanup-buffer-or-region)
    (define-key map (kbd "C-c f")  'prelude-recentf-ido-find-file)
    (define-key map (kbd "C-M-z") 'prelude-indent-defun)
    (define-key map (kbd "C-c u") 'prelude-view-url)
    (define-key map (kbd "C-c e") 'prelude-eval-and-replace)
    (define-key map (kbd "C-c s") 'prelude-swap-windows)
    (define-key map (kbd "C-c D") 'prelude-delete-file-and-buffer)
    (define-key map (kbd "C-c d") 'prelude-duplicate-current-line-or-region)
    (define-key map (kbd "C-c M-d") 'prelude-duplicate-and-comment-current-line-or-region)
    (define-key map (kbd "C-c r") 'prelude-rename-buffer-and-file)
    (define-key map (kbd "C-c t") 'prelude-visit-term-buffer)
    (define-key map (kbd "C-c k") 'prelude-kill-other-buffers)
    (define-key map (kbd "C-c TAB") 'prelude-indent-rigidly-and-copy-to-clipboard)
    (define-key map (kbd "C-c I") 'prelude-find-user-init-file)
    (define-key map (kbd "C-c S") 'prelude-find-shell-init-file)
    (define-key map (kbd "C-c i") 'prelude-goto-symbol)
    ;; extra prefix for projectile
    (define-key map (kbd "s-p") 'projectile-command-map)
    ;; make some use of the Super key
    (define-key map (kbd "s-g") 'god-local-mode)
    (define-key map (kbd "s-r") 'prelude-recentf-ido-find-file)
    (define-key map (kbd "s-j") 'prelude-top-join-line)
    (define-key map (kbd "s-k") 'prelude-kill-whole-line)
    (define-key map (kbd "s-m m") 'magit-status)
    (define-key map (kbd "s-m l") 'magit-log)
    (define-key map (kbd "s-m f") 'magit-log-buffer-file)
    (define-key map (kbd "s-m b") 'magit-blame)
    (define-key map (kbd "s-o") 'prelude-smart-open-line-above)

    map))
