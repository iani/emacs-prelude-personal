;;; SuperCollider-utils --- 2017-08-19 03:34:53 AM
  ;;; Commentary:
  ;;; emacs commands for doing useful things in supercollider.
  ;;; Includes newest version of snippets library.

  ;;; Code:
  ;; (sclang-eval-string string &optional print-p)
  ;; (defun dired-get-filename (&optional localp no-error-if-not-filep)
  ;; Requires Buffers class of sc-hacks lib.

  (defun dired-preview-audio-buffer ()
    "Load file at cursor in dired to sc audio buffer.
  If called with prefix, play the buffer as soon as it is loaded."
    (interactive)
    (message (dired-get-filename))
    (sclang-eval-string
     (format "LoadFile.previewAudio(\"%s\")"
             (dired-get-filename))
     t))

  (defun dired-load-sc-file (&optional loadNow)
    "Load file at cursor in dired to sc audio buffer.
  If called with prefix, play the buffer as soon as it is loaded."
    (interactive "P")
    (let ((paths (dired-get-marked-files)))
      (dolist (path paths)
       (message path)
       (sclang-eval-string
        (format "LoadFile(\"%s\");\nLoadFile.save;\n" path))
       (if loadNow
           (sclang-eval-string
            (format "\"%s\".load", path))))))

  (eval-after-load 'dired
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key dired-mode-map (kbd "C-c C-b") 'dired-preview-audio-buffer)
       (define-key dired-mode-map (kbd "C-c C-l") 'dired-load-sc-file)))

  ;; (global-set-key (kbd "H-d b") 'dired-load-audio-buffer)

  (defun org-sclang-eval-babel-block ()
    "Evaluate current babel code block as sclang code."
    (interactive)
    (let*
        ((element (cadr (org-element-at-point)))
         (code (plist-get element :value)))
      (sclang-eval-string code)))

  (eval-after-load 'org
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key org-mode-map (kbd "C-c C-/") 'org-sclang-eval-babel-block)))

  ;;; key chords for sclang
  (defun sclang-2-windows ()
    "Reconfigure frame to this window and sclang-post-window."
    (interactive)
    (delete-other-windows)
    (sclang-show-post-buffer))

  (defun sclang-plusgt ()
    "Insert +>."
    (interactive)
    (insert "+>"))

  (defun sclang-ltplus ()
    "Insert <+."
    (interactive)
    (insert "<+"))

  (defun sclang-xgt ()
    "Insert *>"
    (interactive)
    (insert "*>"))

  (defun sclang-extensions-gui ()
    "Open gui for browsing user extensions classes and methods.
  Type return on a selected item to open the file where it is defined."
    (interactive)
    (sclang-eval-string "Class.extensionsGui;"))

  (defun scundelify ()
    "Blah."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "\n//:" nil t)
        (replace-match "\n\)\n//:")
        (goto-char (line-end-position 2))
        (goto-char (line-beginning-position 1))
        (insert "\(\n")
        (goto-char (line-beginning-position 1))
        (delete-blank-lines))
      (goto-char (point-min))
      (re-search-forward "\)\n//:" nil t)
      (replace-match "\n://:")))

  (defun sclang-get-current-snippet ()
    "Return region between //: comments in sclang, as string."
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

  (defun sclang-move-snippet-down ()
    "Transpose this snippet with the one following it."
    (interactive)
    (sclang-cut-current-snippet)
    (sclang-goto-next-snippet)
    (insert "\n")
    (yank)
    (delete-blank-lines)
    (re-search-backward "^//:")
    (goto-char (line-end-position 2)))

  (defun sclang-move-snippet-up ()
    "Transpose this snippet with the one preceding it."
    (interactive)
    (sclang-cut-current-snippet)
    (re-search-backward "^//:")
    (yank)
    (re-search-backward "^//:")
    (goto-char (line-end-position 2)))

  (defun sclang-eval-current-snippet ()
    "Evaluate the current snippet in sclang.
  A snippet is a block of code enclosed between comments
  starting at the beginning of line and with a : following immediately after //."
    (interactive)
    (sclang-eval-string (sclang-get-current-snippet)))

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

  (defun sclang-goto-next-snippet ()
    "Go to the next snippet."
    (interactive)
    (goto-char (sclang-end-of-snippet))
    (goto-char (line-end-position 2)))

  (defun sclang-goto-previous-snippet ()
    "Go to the previous snippet."
    (interactive)
    (goto-char (line-end-position))
    (goto-char (sclang-beginning-of-snippet))
    (goto-char (sclang-beginning-of-snippet))
    (goto-char (line-end-position 2))
    (goto-char (line-beginning-position)))

  (eval-after-load 'sclang
    '(progn
       (define-key sclang-mode-map (kbd "M-C-x") 'sclang-eval-current-snippet)
       (define-key sclang-mode-map (kbd "M-C-.") 'sclang-duplicate-current-snippet)
       (define-key sclang-mode-map (kbd "M-n") 'sclang-goto-next-snippet)
       (define-key sclang-mode-map (kbd "M-C-n") 'sclang-eval-next-snippet)
       (define-key sclang-mode-map (kbd "M-C-S-n") 'sclang-move-snippet-down)
       (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
       (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
       (define-key sclang-mode-map (kbd "M-C-p") 'sclang-eval-previous-snippet)
       (define-key sclang-mode-map (kbd "M-C-S-p") 'sclang-move-snippet-up)
       (key-chord-define sclang-mode-map "11" 'sclang-2-windows)
       (key-chord-define sclang-mode-map "''" 'sclang-plusgt)
       (key-chord-define sclang-mode-map ";;" 'sclang-ltplus)
       (key-chord-define sclang-mode-map "\\\\" 'sclang-xgt)))

(provide 'SuperCollider-utils)
;;; 014_SuperCollider-utils.el ends here
