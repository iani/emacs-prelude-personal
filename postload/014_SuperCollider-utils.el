;;; SuperCollider-utils --- 2017-07-25 09:12:43 PM
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

  (global-set-key (kbd "H-d l") 'dired-load-audio-buffer)
(provide 'SuperCollider-utils)
;;; 014_SuperCollider-utils.el ends here
