;;; SuperCollider-extensionsGui --- 2017-10-01 01:03:12 PM
  ;;; Commentary:

  ;;; help-function for adding true paths of sc-lang extensions subfolders.
  ;;; Also define sclang-extensions-gui local keybinding for sclang

  ;;; Code:

  (defun sclang-extensions-gui ()
    "Open gui for browsing user extensions classes and methods.
    Type return on a selected item to open the file where it is defined."
    (interactive)
    (sclang-eval-string "Class.extensionsGui;"))

  (eval-after-load 'sclang
      '(progn
         (define-key sclang-mode-map (kbd "C-h C-e") 'sclang-extensions-gui)))
(provide 'SuperCollider-extensionsGui)
;;; 016_SuperCollider-extensionsGui.el ends here
