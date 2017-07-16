(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
 '(TeX-engine (quote xetex))
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#151718" "#CE4045" "#9FCA56" "#DCCD69" "#55B5DB" "#A074C4" "#55B5DB" "#D4D7D6"])
 '(ansi-term-color-vector
   [unspecified "#1F1611" "#660000" "#144212" "#EFC232" "#5798AE" "#BE73FD" "#93C1BC" "#E6E1DC"] t)
 '(background-color "#202020")
 '(background-mode dark)
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/savefile/bookmarks")
 '(calendar-latitude 39.619)
 '(calendar-longitude 19.919)
 '(cursor-color "#cccctscc")
 '(cursor-type (quote bar))
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("74278d14b7d5cf691c4d846a4bbf6e62d32104986f104c1e61f718f9669ec04b" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "14f0fbf6f7851bfa60bf1f30347003e2348bf7a1005570fd758133c87dafe08f" "1b386f9d14ac6e9ae88ab3993ccf4ccb67d0cb196b4279126a85bd8e03269f7d" "8dc4a35c94398efd7efee3da06a82569f660af8790285cd211be006324a4c19a" "b571f92c9bfaf4a28cb64ae4b4cdbda95241cd62cf07d942be44dc8f46c491f4" default)))
 '(default-frame-alist nil)
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(emms-mode-line-icon-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *note[] = {
/* width height num_colors chars_per_pixel */
\"    10   11        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"###...####\",
\"###.#...##\",
\"###.###...\",
\"###.#####.\",
\"###.#####.\",
\"#...#####.\",
\"....#####.\",
\"#..######.\",
\"#######...\",
\"######....\",
\"#######..#\" };")))
 '(fci-rule-character-color "#452E2E")
 '(fci-rule-color "#14151E" t)
 '(foreground-color "#cccccc")
 '(fringe-mode 4 nil (fringe))
 '(global-rainbow-blocks-mode t)
 '(gnus-logo-colors (quote ("#0d7b72" "#adadad")) t)
 '(gnus-mode-line-image-cache
   (quote
    (image :type xpm :ascent center :data "/* XPM */
static char *gnus-pointer[] = {
/* width height num_colors chars_per_pixel */
\"    18    13        2            1\",
/* colors */
\". c #358d8d\",
\"# c None s None\",
/* pixels */
\"##################\",
\"######..##..######\",
\"#####........#####\",
\"#.##.##..##...####\",
\"#...####.###...##.\",
\"#..###.######.....\",
\"#####.########...#\",
\"###########.######\",
\"####.###.#..######\",
\"######..###.######\",
\"###....####.######\",
\"###..######.######\",
\"###########.######\" };")) t)
 '(guru-global-mode nil)
 '(helm-grep-preferred-ext "*.org")
 '(highlight-symbol-colors
   (quote
    ("#EFFF00" "#73CD4F" "#83DDFF" "MediumPurple1" "#66CDAA" "DarkOrange" "HotPink1" "#809FFF" "#ADFF2F")))
 '(hl-paren-background-colors
   (quote
    ("#00FF99" "#CCFF99" "#FFCC99" "#FF9999" "#FF99CC" "#CC99FF" "#9999FF" "#99CCFF" "#99FFCC" "#7FFF00")))
 '(hl-paren-colors (quote ("#326B6B")))
 '(hl-sexp-background-colors (quote ("gray0" "#0f003f")))
 '(icicle-buffer-configs
   (quote
    (("icybufferconfig1" "Event*" "\\.ck" nil nil nil)
     ("All" nil nil nil nil icicle-case-string-less-p)
     ("Files" nil nil
      (lambda
        (bufname)
        (buffer-file-name
         (get-buffer bufname)))
      nil icicle-case-string-less-p)
     ("Files and Scratch" nil nil
      (lambda
        (bufname)
        (buffer-file-name
         (get-buffer bufname)))
      ("*scratch*")
      icicle-case-string-less-p)
     ("All, *...* Buffers Last" nil nil nil nil icicle-buffer-sort-*\.\.\.*-last))))
 '(icicle-mode nil)
 '(linum-format " %7d ")
 '(magit-use-overlays nil)
 '(main-line-color1 "#1E1E1E")
 '(main-line-color2 "#111111")
 '(main-line-separator-style (quote chamfer))
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(ns-right-command-modifier (quote meta))
 '(org-agenda-files
   (quote
    ("/Users/iani/Documents/000WORKFILES/2_PROJECTS_PERMANENT/AVARTS/POST_DOC/URSUS_POST_DOC_RESEARCH_SCHOLARSHIPS_1612ff.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/DIARY.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/19700117.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20140101.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20160901.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20161110.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170124.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170202.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170205.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170206.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170207.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170208.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170209.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170211.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170213.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170214.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170215.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170216.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170217.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170223.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170303.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170304.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170307.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170308.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170309.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170312.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170324.org" "/Users/iani/Documents/000WORKFILES/PERSONAL/journal/20170420.org")))
 '(org-attach-directory "/Users/iani/Documents/org-attachments/")
 '(org-drill-optimal-factor-matrix (quote ((1 (2.5 . 4.0) (1.96 . 3.58)))))
 '(org-export-backends (quote (ascii html icalendar latex md odt s5 taskjuggler)))
 '(org-export-with-sub-superscripts (quote {}))
 '(org-hide-leading-stars t)
 '(org-journal-file-format "%Y%m%d.org")
 '(org-log-into-drawer t)
 '(org-mobile-directory "~/Dropbox/Apps/MobileOrg")
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-crypt org-docview org-gnus org-habit org-id org-info org-drill org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-mac-iCal)))
 '(org-src-fontify-natively t)
 '(org-startup-indented t)
 '(org-tags-column -50)
 '(package-selected-packages
   (quote
    (org-mac-iCal ox-reveal epresent org-tree-slide stylus-mode desktop+ haskell-mode molokai-theme php-mode auctex org-journal elfeed-org auto-org-md yaml-mode zop-to-char zenburn-theme volatile-highlights vkill use-package swiper-helm sr-speedbar smex smartrep smartparens smart-mode-line sclang-extensions rainbow-mode rainbow-delimiters powerline paredit-menu paredit-everywhere ox-twbs ov org-drill-table operate-on-number move-text moe-theme migemo mc-extras markdown-mode magit litable linum-relative less-css-mode kivy-mode key-chord json-mode ido-ubiquitous hl-sexp hl-sentence hl-anything helm-w3m helm-projectile helm-descbinds helm-ag guru-mode grizzl god-mode gitignore-mode gitconfig-mode git-timemachine gist flycheck flx-ido expand-region exec-path-from-shell evil elisp-slime-nav easy-kill discover-my-major dired+ diff-hl deft csv-mode company calfw buffer-move browse-kill-ring bookmark+ beacon avy-zap avy-menu auto-async-byte-compile anzu ace-window ace-popup-menu ace-isearch)))
 '(pdf-view-midnight-colors (quote ("#DCDCCC" . "#383838")))
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(rainbow-identifiers-cie-l*a*b*-lightness 25)
 '(rainbow-identifiers-cie-l*a*b*-saturation 40)
 '(safe-local-variable-values
   (quote
    ((buffer-face-mode-face :family "Source Code Pro" :height 110)
     (org-provide-todo-statistics "TUN" "PRÜFEN"))))
 '(tab-width 4)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#d54e53")
     (40 . "goldenrod")
     (60 . "#e7c547")
     (80 . "DarkOliveGreen3")
     (100 . "#70c0b1")
     (120 . "DeepSkyBlue1")
     (140 . "#c397d8")
     (160 . "#d54e53")
     (180 . "goldenrod")
     (200 . "#e7c547")
     (220 . "DarkOliveGreen3")
     (240 . "#70c0b1")
     (260 . "DeepSkyBlue1")
     (280 . "#c397d8")
     (300 . "#d54e53")
     (320 . "goldenrod")
     (340 . "#e7c547")
     (360 . "DarkOliveGreen3"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#303030" :foreground "#c6c6c6" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 140 :width normal :foundry "nil" :family "Inconsolata"))))
 '(aw-background-face ((t (:background "#3F3F3F" :foreground "red3" :inverse-video nil))))
 '(cfw:face-annotation ((t :foreground "RosyBrown" :inherit cfw:face-day-title)))
 '(cfw:face-day-title ((t :background "grey10")))
 '(cfw:face-default-content ((t :foreground "#bfebbf")))
 '(cfw:face-default-day ((t :weight bold :inherit cfw:face-day-title)))
 '(cfw:face-disable ((t :foreground "DarkGray" :inherit cfw:face-day-title)))
 '(cfw:face-grid ((t :foreground "DarkGrey")))
 '(cfw:face-header ((t (:foreground "#d0bf8f" :weight bold))))
 '(cfw:face-holiday ((t :background "grey10" :foreground "#8c5353" :weight bold)))
 '(cfw:face-periods ((t :foreground "cyan")))
 '(cfw:face-saturday ((t :foreground "#8cd0d3" :background "grey10" :weight bold)))
 '(cfw:face-select ((t :background "#2f2f2f")))
 '(cfw:face-sunday ((t :foreground "#cc9393" :background "grey10" :weight bold)))
 '(cfw:face-title ((t (:foreground "#f0dfaf" :weight bold :height 2.0 :inherit variable-pitch))))
 '(cfw:face-today ((t :background: "grey10" :weight bold)))
 '(cfw:face-today-title ((t :background "#7f9f7f" :weight bold)))
 '(cfw:face-toolbar ((t :foreground "Steelblue4" :background "Steelblue4")))
 '(cfw:face-toolbar-button-off ((t :foreground "Gray10" :weight bold)))
 '(cfw:face-toolbar-button-on ((t :foreground "Gray50" :weight bold)))
 '(cursor ((t (:background "#FF5" :foreground "#000"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "sky blue" :slant italic))))
 '(font-lock-comment-face ((t (:foreground "rosy brown" :slant italic))))
 '(helm-buffer-directory ((t (:background "DarkRed" :foreground "LightGray"))))
 '(helm-selection ((t (:background "#703" :underline t))))
 '(hl-line ((t (:background "alternateSelectedControlColor"))))
 '(hl-sexp-face ((t (:background "gray10"))))
 '(info-title-3 ((t (:inherit info-title-4 :foreground "white" :height 1.2))))
 '(info-title-4 ((t (:inherit info-title-4 :foreground "black"))))
 '(mode-line ((t (:background "#6483af" :foreground "#001122" :box (:line-width 1 :color "#6483af") :weight ultra-bold :height 118 :family "Monospace"))))
 '(org-block-end-line ((t (:background "#3a3a3a" :foreground "gray45" :slant italic))))
 '(org-level-1 ((t (:weight bold :height 1.1))))
 '(org-level-2 ((t (:weight bold :height 1.1))))
 '(org-level-3 ((t (:weight bold :height 1.1))))
 '(org-level-4 ((t (:weight bold :height 1.1))))
 '(org-level-5 ((t (:weight bold :height 1.1))))
 '(org-level-6 ((t (:weight bold :height 1.1))))
 '(org-level-7 ((t (:weight bold :height 1.1))))
 '(org-level-8 ((t (:weight bold :height 1.1))))
 '(org-level-9 ((t (:weight bold :height 1.1))))
 '(org-meta-line ((t (:background "black" :foreground "pink1"))))
 '(rainbow-blocks-depth-5-face ((t (:foreground "gray87"))))
 '(rainbow-delimiters-depth-1-face ((t (:foreground "brown1"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#33FF66"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#009933"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#3366FF"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#77BBFF"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#FFAACC"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "gold1"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "red")))))
