
;; (sclang-eval-string string &optional print-p)
;; (defun dired-get-filename (&optional localp no-error-if-not-filep)
;; Requires Buffers class of sc-hacks lib.

(defun dired-load-audio-buffer (&optional play)
  "Load file at cursor in dired to sc audio buffer."
  (interactive "P")
  (message (dired-get-filename))
  (sclang-eval-string
   (format "Buffers.load(\"%s\", %s)"
           (dired-get-filename)
           (if play "true" "false"))
   t))

(global-set-key (kbd "H-d l") 'dired-load-audio-buffer)
