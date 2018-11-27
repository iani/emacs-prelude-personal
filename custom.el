(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/savefile/bookmarks")
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("091d65b8289d2b3a4fb8ccf674080c0daae37c08ff658d9295b45dc6b26627eb" "e11569fd7e31321a33358ee4b232c2d3cf05caccd90f896e1df6cab228191109" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "b9cbfb43711effa2e0a7fbc99d5e7522d8d8c1c151a3194a4b176ec17c9a8215" "ee4dcfcb646d4ad11fe1bd90ed111e3e59a78703325fdef347b50a39ccba13d7" "30f7c9e85d7fad93cf4b5a97c319f612754374f134f8202d1c74b0c58404b8df" "291588d57d863d0394a0d207647d9f24d1a8083bb0c9e8808280b46996f3eb83" "4025fb8d0a40f678a724940dd3d0609546654c3e757ad4844b321b896a6a0ea7" default))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(org-export-backends '(ascii html icalendar latex texinfo))
 '(org-imenu-depth 10)
 '(package-selected-packages
   '(flycheck-lilypond ac-c-headers use-package ox-hugo corral hydra rust-mode image-dired+ org-ref ebib auctex org-mode org-plus-contrib helm-swoop tidal tiny-menu osx-plist flymake-haskell-multi haskell-emacs haskell-mode org-bullets markdown-mode deft evil workgroups2 org-journal buffer-move dired+ easy-hugo calfw-cal calfw-org calfw auto-complete hl-sexp icicles litable sr-speedbar bookmark+ autobookmarks bm ace-mc mc-extras multiple-cursors ace-isearch ace-popup-menu auto-async-byte-compile avy-menu avy-zap multi-term powerline moe-theme zop-to-char zenburn-theme which-key volatile-highlights undo-tree smex smartrep smartparens smart-mode-line rainbow-mode rainbow-delimiters ov operate-on-number move-text magit key-chord json-mode js2-mode imenu-anywhere ido-completing-read+ helm-projectile helm-descbinds helm-ag guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist geiser flycheck flx-ido expand-region elisp-slime-nav editorconfig easy-kill discover-my-major diminish diff-hl crux company browse-kill-ring beacon anzu ace-window))
 '(pdf-view-midnight-colors '("#DCDCCC" . "#383838"))
 '(safe-local-variable-values
   '((org-babel-noweb-wrap-end . "»")
     (org-babel-noweb-wrap-start . "«")
     (eval require 'lob-gadget)
     (eval require 'lob-core)
     (eval require 'ob-shell-term)
     (eval require 'ob-source-hacks)))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3"))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(default ((t (:family "Courier New" :foundry "nil" :width normal :height 110 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#DCDCCC" :background "#3F3F3F" :stipple nil :inherit nil))))
;;  '(aw-leading-char-face ((t (:weight bold :foreground "white" :background "red" :inherit (aw-mode-line-face)))))
;;  '(font-lock-comment-delimiter-face ((t (:slant italic :foreground "SeaGreen4"))))
;;  '(font-lock-comment-face ((t (:slant italic :foreground "coral1"))))
;;  '(font-lock-variable-name-face ((t (:foreground "turquoise2"))))
;;  '(helm-selection ((t (:underline nil :background "MediumOrchid1" :foreground "white"))))
;;  '(hl-line ((t (:background "red4"))))
;;  '(hl-sexp-face ((t (:background "gray10"))))
;;  '(info-title-3 ((t (:inherit info-title-4 :foreground "white" :height 1.2))))
;;  '(info-title-4 ((t (:inherit info-title-4 :foreground "red"))))
;;  '(mode-line ((t (:background "DarkCyan" :foreground "tomato" :box (:line-width 1 :color "turquoise3") :weight light :height 118 :family "Monospace"))))
;;  '(org-block-begin-line ((t (:background "#3a2a2f" :foreground "gray99"))))
;;  '(org-block-end-line ((t (:background "#2a2a2f" :foreground "gray99"))))
;;  '(org-level-1 ((t (:family "Helvetica" :height 1.1 :weight bold))))
;;  '(org-level-2 ((t (:inherit outline-2 :foreground "#a1db00" :box nil :weight light :height 1.1 :family "Inconsolata"))))
;;  '(org-level-3 ((t (:weight bold :height 1.1))))
;;  '(org-level-4 ((t (:inherit outline-4 :foreground "#00d7af" :box nil :slant normal :weight bold :height 1.1))))
;;  '(org-level-5 ((t (:weight bold :height 1.1))))
;;  '(org-level-6 ((t (:weight bold :height 1.1))))
;;  '(org-level-7 ((t (:weight bold :height 1.1))))
;;  '(org-level-8 ((t (:weight bold :height 1.1))))
;;  '(org-level-9 ((t (:weight bold :height 1.1))))
;;  '(org-priority ((t (:background "#ff5959" :foreground "gray99"))))
;;  '(region ((t (:background "thistle4" :foreground nil)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight ((t (:foreground "#FaFbff" :background "#119191"))))
 '(hl-line ((t (:background "gray90"))))
 '(hl-sexp-face ((t (:background "gray80"))))
 '(org-block ((t (:foreground "#005f87" :background "#17271f"))))
 '(org-block-begin-line ((t (:background "#3a2a2f" :foreground "gray99"))))
 '(org-block-end-line ((t (:background "#2a2a2f" :foreground "gray99"))))
 '(org-level-1 ((t (:family "Helvetica" :height 1.1 :weight bold))))
 '(org-level-2 ((t (:family "Inconsolata" :height 1.1 :weight light :box nil :foreground "#a1db00" :inherit (outline-2)))))
 '(org-level-3 ((t (:weight bold :height 1.1))))
 '(org-level-4 ((t (:weight bold :height 1.1))))
 '(org-level-5 ((t (:weight bold :height 1.1))))
 '(org-level-6 ((t (:weight bold :height 1.1))))
 '(org-level-7 ((t (:weight bold :height 1.1))))
 '(org-level-8 ((t (:weight bold :height 1.1))))
 '(org-level-9 ((t (:weight bold :height 1.1))))
 '(org-link ((t (:underline (:color "#1f0bff" :style line) :foreground "#FfFbff" :background "#F11111"))))
 '(org-priority ((t (:background "#ff5959" :foreground "gray99"))))
 '(region ((t (:background "thistle4" :foreground nil)))))
