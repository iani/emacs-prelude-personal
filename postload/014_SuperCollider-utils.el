;;; SuperCollider-utils --- 2017-08-06 03:31:52 PM
  ;;; Commentary:
  ;;; emacs commands for doing useful things in supercollider.

  ;;; Code:
  ;; (sclang-eval-string string &optional print-p)
  ;; (defun dired-get-filename (&optional localp no-error-if-not-filep)
  ;; Requires Buffers class of sc-hacks lib.

  (defun dired-load-audio-buffer (&optional play)
    "Load file at cursor in dired to sc audio buffer.
  If called with prefix, play the buffer as soon as it is loaded."
    (interactive "P")
    (message (dired-get-filename))
    (sclang-eval-string
     (format "Buffers.load(\"%s\", %s)"
             (dired-get-filename)
             (if play "true" "false"))
     t))

  (defun dired-load-sc-file (&optional loadNow)
    "Load file at cursor in dired to sc audio buffer.
  If called with prefix, play the buffer as soon as it is loaded."
    (interactive "P")
    (let ((path (dired-get-filename)))
      (message path)
     (sclang-eval-string
      (format "LoadFile(\"%s\");\nLoadFile.save;\n"
              (dired-get-filename)))
     (if loadNow
         (sclang-eval-string
          (format "\"%s\".load", path)))
     ))

  (eval-after-load 'dired
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key dired-mode-map (kbd "C-c C-b") 'dired-load-audio-buffer)
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
(provide 'SuperCollider-utils)
;;; 014_SuperCollider-utils.el ends here
