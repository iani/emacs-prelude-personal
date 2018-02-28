;;; whitespace_and_visual_line_fixes --- 2018-02-28 04:14:08 PM
;;; Commentary:
;;; turn off whitespace and turn on visual line modes,
;;; for these main modes:
;;; js, css, web, html, markdown

(defun whitespace-off ()
  "Make turning whitespace mode off a command callable from key."
  (interactive)
  (whitespace-mode -1))

(add-hook 'markdown-mode-hook 'whitespace-off)
(add-hook 'css-mode-hook 'whitespace-off)
(add-hook 'html-mode-hook 'whitespace-off)
(add-hook 'web-mode-hook 'whitespace-off)
(add-hook 'js-mode-hook 'whitespace-off)

(add-hook 'markdown-mode-hook 'visual-line-mode)
(add-hook 'css-mode-hook 'visual-line-mode)
(add-hook 'html-mode-hook 'visual-line-mode)
(add-hook 'web-mode-hook 'visual-line-mode)
(add-hook 'js-mode-hook 'visual-line-mode)

(provide 'whitespace_and_visual_line_fixes)
;;; 009_whitespace_and_visual_line_fixes.el ends here
