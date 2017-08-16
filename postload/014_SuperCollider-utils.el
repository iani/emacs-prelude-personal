;;; SuperCollider-utils --- 2017-08-16 01:46:00 PM
  ;;; Commentary:
  ;;; emacs commands for doing useful things in supercollider.

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

  (eval-after-load 'sclang
    '(progn
       (define-key sclang-mode-map (kbd "C-c C-e") 'sclang-extensions-gui)
       (key-chord-define sclang-mode-map "11" 'sclang-2-windows)
       (key-chord-define sclang-mode-map ".." 'sclang-plusgt)
       (key-chord-define sclang-mode-map ",," 'sclang-ltplus)
       (key-chord-define sclang-mode-map ">>" 'sclang-xgt)))
(provide 'SuperCollider-utils)
;;; 014_SuperCollider-utils.el ends here
