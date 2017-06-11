;;; line2shell --- copy current line and paste to shell in other window

;;; Commentary:

;;; Facilitate the execution of series of commands,
;; by copying them over line-by-line from any notebook buffer to the shell terminal.

;;; Code:

(defun copy-line-2-shell ()
  "Copy current line, switch window, and paste."
  (interactive)
  (move-beginning-of-line nil)
  (push-mark)
  (move-end-of-line nil)
  (copy-region-as-kill (mark) (point))
  (other-window 1)
  (yank)
  )

(provide '022-line2shell)
;;; 022_line2shell.el ends here

