(add-hook 'sclang-mode-hook
          (lambda()
            (local-set-key (kbd "H-b b") 'hs-toggle-hiding)
            (local-set-key (kbd "H-b H-b")  'hs-hide-block)
            (local-set-key (kbd "H-b a")    'hs-hide-all)
            (local-set-key (kbd "H-b H-a")  'hs-show-all)
            (local-set-key (kbd "H-b l")  'hs-hide-level)
            (local-set-key (kbd "H-b H-l")  'hs-show-level)
            (hs-minor-mode 1)))
