(add-hook 'evil-mode-hook
          (lambda ()
            (if evil-mode
                (linum-relative-mode 1)
              (linum-relative-mode -1))))

(global-set-key (kbd "s-:") 'evil-mode)
