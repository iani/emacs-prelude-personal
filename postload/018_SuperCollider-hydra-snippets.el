;;; SuperCollider-hydra-snippets --- 2019-03-24 06:03:22 PM
  (defhydra hydra-snippets (sclang-mode-map "C-h C-s" :color red :columns 3)
    "SC Snippet hydra"
    ("n" sclang-goto-next-snippet "next")
    ("p" sclang-goto-previous-snippet "previous")
    ("N" sclang-goto-next-heading "next heading")
    ("P" sclang-goto-previous-heading "previous heading")
    ("x" sclang-cut-current-snippet "cut")
    ("c" sclang-copy-current-snippet "copy")
    ("2" sclang-duplicate-current-snippet "duplicate")
    ;; ("s" sclang-copy-current-snippet "select")
    ("u" sclang-transpose-snippet-up "transpose up")
    ("d" sclang-transpose-snippet-down "transpose down")
    ("." sclang-eval-current-snippet "eval")
    ("[" sclang-eval-previous-snippet "eval prev")
    ("]" sclang-eval-next-snippet "eval next")
    ("e" sclang-extensions-gui "browse classes and methods")
    ("C-p" sclang-players-gui "players gui")
    ("q" quit "quit" :exit t))

  (defun quit ()
    "Empty function placeholder to quit hydras."
    (interactive)
    (message "quit"))

  (defun sclang-get-current-snippet ()
    "Return region between //: comments in sclang, as string.
    If the beginning of line is '//:+', then fork the snippet as routine.
    If the beginning of line is '//:*', then wrap the snippet in loop and fork."
    (save-excursion
      (goto-char (line-end-position)) ;; fix when starting from point-min
      (let (
            (snippet-begin (search-backward-regexp "^//:" nil t))
            snippet-end
            snippet
            snippet-head
            (prefix ""))
        (unless snippet-begin
          (setq snippet-begin (point-min))
          (setq prefix "//:\n"))
        (setq sclang-snippet-is-routine nil)
        (setq sclang-snippet-is-loop nil)
        (goto-char snippet-begin)
        (setq snippet-head (buffer-substring-no-properties (point) (+ 4 (point))))
        (if (equal snippet-head "//:+") (setq sclang-snippet-is-routine t))
        (if (equal snippet-head "//:*") (setq sclang-snippet-is-loop t))
        (goto-char (line-end-position))
        (setq snippet-end (search-forward-regexp "^//:" nil t))
        (if snippet-end
            (setq snippet-end (line-beginning-position))
          (setq snippet-end (point-max)))
        (concat prefix
                (buffer-substring-no-properties snippet-begin snippet-end)))))

  (defun sclang-cut-current-snippet ()
    "Return region between //: comments in sclang, as string, and cut it out."
    (interactive)
    (save-excursion
      (goto-char (line-end-position)) ;; fix when starting from point-min
      (let (
            (snippet-begin (search-backward-regexp "^//:" nil t))
            snippet-end
            snippet
            (prefix ""))
        (unless snippet-begin
          (setq snippet-begin (point-min))
          (setq prefix "//:\n"))
        (goto-char (line-end-position))
        (setq snippet-end (search-forward-regexp "^//:" nil t))
        (if snippet-end
            (setq snippet-end (line-beginning-position))
          (setq snippet-end (point-max)))
        (setq snippet (concat prefix
                              (buffer-substring-no-properties snippet-begin snippet-end)))
        (kill-region snippet-begin snippet-end))))

  (defun sclang-transpose-snippet-down ()
    "Transpose this snippet with the one following it."
    (interactive)
    (sclang-cut-current-snippet)
    (sclang-goto-next-snippet)
    (insert "\n")
    (yank)
    (delete-blank-lines)
    (re-search-backward "^//:")
    (goto-char (line-end-position 2)))

  (defun sclang-transpose-snippet-up ()
    "Transpose this snippet with the one preceding it."
    (interactive)
    (sclang-cut-current-snippet)
    (re-search-backward "^//:")
    (yank)
    (re-search-backward "^//:")
    (goto-char (line-end-position 2)))

  (defun sclang-eval-current-snippet (&optional player-p)
    "Evaluate the current snippet in sclang.
    If PLAYER-P, then append +> PLAYERNAME.
    PLAYERNAME is filename without extension.
    A snippet is a block of code enclosed between comments
    starting at the beginning of line and with a : following immediately after '//'.
    If the beginning of line is '//:+', then fork the snippet as routine.
    If the beginning of line is '//:*', then wrap the snippet in loop and fork."
    (interactive "P")
    (let* (sclang-snippet-is-routine
           sclang-snippet-is-loop
           (snippet (sclang-get-current-snippet)))
      (if sclang-snippet-is-routine
          (setq snippet (format "{\n %s\n }.fork" snippet)))
      (if sclang-snippet-is-loop
          (setq snippet (format "{\n loop {\n %s \n} \n }.fork" snippet)))
      (sclang-eval-string
       (if player-p
           (concat snippet " +> \\"
                   (file-name-sans-extension
                    (file-name-nondirectory (buffer-file-name))))
           snippet) t)))

  (defun sclang-goto-next-snippet ()
    "Go to the next snippet."
    (interactive)
    (goto-char (sclang-end-of-snippet))
    (goto-char (line-end-position 2))
    (goto-char (line-beginning-position)))

  (defun sclang-goto-next-heading ()
    "Go to the next snippet heading."
    (interactive)
    (goto-char (sclang-end-of-snippet))
    (forward-char 3)
    ;; (goto-char (line-end-position 2))
    ;; (goto-char (line-beginning-position))
    )

  (defun sclang-goto-previous-snippet ()
    "Go to the previous snippet."
    (interactive)
    (goto-char (line-end-position))
    (let ((pos (search-backward-regexp "^//:" nil t)))
      (if (and pos (> pos 1)) (goto-char (1- pos)))
      (setq pos (search-backward-regexp "^//:" nil t))
      (cond
       (pos
        (goto-char pos)
        (goto-char (1+ (line-end-position)))
        (goto-char (line-beginning-position)))
       (t
        (goto-char (point-min))))
      ;; (re-search-backward "^//:")
      ))

  (defun sclang-goto-previous-heading ()
    "Go to the previous snippet heading."
    (interactive)
    (goto-char (line-end-position))
    (let ((pos (search-backward-regexp "^//:" nil t)))
      (if (and pos (> pos 1)) (goto-char (1- pos)))
      (setq pos (search-backward-regexp "^//:" nil t))
      (cond
       (pos
        (goto-char (+ 3 pos))
        ;; (goto-char (1+ (line-end-position)))
        ;; (goto-char (line-beginning-position))
        )
       (t
        (goto-char (point-min))))
      ;; (re-search-backward "^//:")
      ))
  (defun sclang-eval-next-snippet ()
    "Go to the next snippet and evaluate it."
    (interactive)
    (sclang-goto-next-snippet)
    (sclang-eval-current-snippet))

  (defun sclang-eval-previous-snippet ()
    "Go to the previous snippet and evaluate it."
    (interactive)
    (sclang-goto-previous-snippet)
    (sclang-eval-current-snippet))

  (defun sclang-duplicate-current-snippet ()
    "Insert a copy the current snippet below itself."
    (interactive)
    (let ((snippet (sclang-get-current-snippet)))
      (goto-char (line-end-position))
      (goto-char (sclang-end-of-snippet))
      (if (eq (point) (point-max)) (insert "\n"))
      (insert snippet)))

  (defun sclang-copy-current-snippet ()
    "Copy the current snippet into the kill ring."
    (interactive)
    (let ((snippet (sclang-get-current-snippet)))
      (kill-new snippet)))

  (defun sclang-region-select-current-snippet ()
    "Select region between //: comments in sclang."
    (save-excursion
      (goto-char (line-end-position)) ;; fix when starting from point-min
      (let (
            (snippet-begin (search-backward-regexp "^//:" nil t))
            snippet-end
            snippet
            snippet-head)
        (unless snippet-begin
          (setq snippet-begin (point-min)))
        (goto-char snippet-begin)
        (goto-char (line-end-position))
        (setq snippet-end (search-forward-regexp "^//:" nil t))
        (if snippet-end
            (setq snippet-end (line-beginning-position))
          (setq snippet-end (point-max)))
        (goto-char snippet-begin)
        (push-mark snipet-end)
        (setq mark-active t))))

  ;; (defun sclang-cut-current-snippet ()
  ;;   "Kill the current snippet, storing it in kill-ring."
  ;;   (sclang-region-select-current-snippet)
  ;;   (kill-region (mark) (point)))

  (defun sclang-end-of-snippet ()
    "Return the point position of the end of the current snippet."
    (save-excursion
      (let ((pos (search-forward-regexp "^//:" nil t)))
        (if pos (line-beginning-position) (point-max)))))

  (defun sclang-beginning-of-snippet ()
    "Return the point position of the beginning of the current snippet."
    (save-excursion
      (goto-char (line-end-position))
      (let ((pos (search-backward-regexp "^//:" nil t)))
        (if pos pos (point-min)))))

  (defun sclang-insert-snippet-separator (&optional before)
    "Insert snippet separator //: at beginning of line."
    (interactive "P")
    (cond
     (before
      (goto-char (line-beginning-position))
      (insert "//:\n"))
     (t
      (goto-char (line-end-position))
      (insert "\n//:"))
     ))

  (defun sclang-insert-snippet-separator+ (&optional before)
    "Insert snippet separator //:+ at beginning of line."
    (interactive "P")
    (cond (before
           (goto-char (line-beginning-position))
           (insert "//:+\n"))
          (t
           (goto-char (line-end-position))
           (insert "\n//:+"))
          ))

  (defun sclang-insert-snippet-separator* (&optional before)
    "Insert snippet separator //:* at beginning of line."
    (interactive "P")
    (cond (before
           (goto-char (line-beginning-position))
           (insert "//:*\n"))
          (t
           (goto-char (line-end-position))
           (insert "\n//:*"))
          ))
(provide 'SuperCollider-hydra-snippets)
;;; 018_SuperCollider-hydra-snippets.el ends here
