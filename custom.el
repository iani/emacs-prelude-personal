(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Linum-format "%7i ")
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
 '(default-frame-alist (quote ((font . "Anonymous Pro for Powerline-12"))))
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
 '(ns-right-command-modifier (quote meta))
 '(org-agenda-files
   (quote
    ("/Users/iani/MEGA/000WORKFILES/PERSONAL/DIARY.org")))
 '(org-attach-directory "./attachments" t)
 '(org-drill-optimal-factor-matrix (quote ((1 (2.5 . 4.0) (1.96 . 3.58)))))
 '(org-export-backends (quote (ascii html icalendar latex md odt taskjuggler)))
 '(org-export-with-sub-superscripts (quote {}))
 '(org-hide-leading-stars t)
 '(org-log-into-drawer t)
 '(org-mobile-directory "~/Dropbox/Apps/MobileOrg")
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-crypt org-docview org-gnus org-id org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m org-mac-iCal)))
 '(org-src-fontify-natively t)
 '(org-startup-indented t)
 '(org-tags-column -50)
 '(powerline-color1 "#1E1E1E")
 '(powerline-color2 "#111111")
 '(rainbow-identifiers-cie-l*a*b*-lightness 25)
 '(rainbow-identifiers-cie-l*a*b*-saturation 40)
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
 '(default ((t (:background nil))))
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
 '(helm-buffer-directory ((t (:background "DarkRed" :foreground "LightGray"))))
 '(helm-selection ((t (:background "#703" :underline t))))
 '(hl-line ((t (:background "gray0"))))
 '(hl-sexp-face ((t (:background "gray10"))))
 '(info-title-3 ((t (:inherit info-title-4 :foreground "white" :height 1.2))))
 '(info-title-4 ((t (:inherit info-title-4 :foreground "black"))))
 '(mode-line ((t (:background "#6483af" :foreground "#001122" :box (:line-width 1 :color "#6483af") :weight ultra-bold :height 118 :family "Monospace"))))
 '(org-block-end-line ((t (:background "#3a3a3a" :foreground "gray45" :slant italic))) t)
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
 '(rainbow-delimiters-depth-1-face ((t (:foreground "#CCFFCC"))))
 '(rainbow-delimiters-depth-2-face ((t (:foreground "#33FF66"))))
 '(rainbow-delimiters-depth-3-face ((t (:foreground "#009933"))))
 '(rainbow-delimiters-depth-4-face ((t (:foreground "#3366FF"))))
 '(rainbow-delimiters-depth-5-face ((t (:foreground "#77BBFF"))))
 '(rainbow-delimiters-depth-6-face ((t (:foreground "#FFAACC"))))
 '(rainbow-delimiters-depth-7-face ((t (:foreground "gold1"))))
 '(rainbow-delimiters-depth-8-face ((t (:foreground "orange"))))
 '(rainbow-delimiters-depth-9-face ((t (:foreground "red")))))
