;;; tiny_menu_and_hydra --- 2018-05-15 08:58:57 PM
  ;;; Commentary:

  ;; 2 tiny-menus for functions that I do not want to place on command-keys,
  ;; from: https://blog.aaronbieber.com/2016/07/31/org-navigation-revisited.html

  ;;; Code:
  (prelude-load-require-packages '(tiny-menu hydra corral))

  (defun air--org-global-custom-ids ()
    "Find custom ID fields in all org agenda files."
    (let ((files (org-agenda-files))
          file
          air-all-org-custom-ids)
      (while (setq file (pop files))
        (with-current-buffer (org-get-agenda-file-buffer file)
          (save-excursion
            (save-restriction
              (widen)
              (goto-char (point-min))
              (while (re-search-forward "^[ \t]*:CUSTOM_ID:[ \t]+\\(\\S-+\\)[ \t]*$"
                                        nil t)
                (add-to-list 'air-all-org-custom-ids
                             `(,(match-string-no-properties 1)
                               ,(concat file ":" (number-to-string (line-number-at-pos))))))))))
      air-all-org-custom-ids))
  (defun air-org-goto-custom-id ()
    "Go to the location of a custom ID, selected interactively."
    (interactive)
    (let* ((all-custom-ids (air--org-global-custom-ids))
           (custom-id (completing-read
                       "Custom ID: "
                       all-custom-ids)))
      (when custom-id
        (let* ((val (cadr (assoc custom-id all-custom-ids)))
               (id-parts (split-string val ":"))
               (file (car id-parts))
               (line (string-to-int (cadr id-parts))))
          (pop-to-buffer (org-get-agenda-file-buffer file))
          (goto-char (point-min))
          (forward-line line)
          (org-reveal)
          (org-up-element)))))

  ;; The helm menu does not update when changing the org-refile-targets variable like this.
  ;; Switch to icicle mode as a workaround.
  (defun air-goto-section ()
    "Set refile targets to current buffer and call org-refile with 1 u prefix."
    (interactive)
    (let ((org-refile-targets `((,buffer-file-name :maxlevel . 10))))
      (icy-mode 1)
      (org-refile '(4))
      (icy-mode -1)))

  (defun air-turn-icicles-on ()
    "Turn icicle mode on."
    (interactive)
    (icy-mode 1))

  (defun air-turn-icicles-off ()
    "Turn icicle mode off."
    (interactive)
    (icy-mode 0))

  (defun air-journal-goto-date ()
    "Jump to journal at date from user"
    (interactive)
    (org-journal-at-date-from-user '(4)))

  (defun sclang-kill-all-servers ()
    "Kill all supercollider servers."
    (interactive)
    (sclang-eval-string "Server.killAll" t))

  (defvar sclang-num-recording-chans 2
    "Default number of recording channels in supercollider")

  (defvar sclang-num-input-chans 2
    "Default number of audio input channels in supercollider")

  (defvar sclang-num-output-chans 2
    "Default number of audio output channels in supercollider")

  (defun sclang-sclang-set-io-channels ()
    "Kill all supercollider servers."
    (interactive)
    (setq sclang-num-input-chans
          (eval-minibuffer "number of input channels: " (format "%d" sclang-num-input-chans)))
    (setq sclang-num-output-chans
          (eval-minibuffer "number of output channels: " (format "%d" sclang-num-output-chans)))
    (sclang-eval-string (format
                         "Server.default.options.numOutputBusChannels = %d"
                         sclang-num-output-chans) t)
    (sclang-eval-string (format
                         "Server.default.options.numInputBusChannels = %d"
                         sclang-num-input-chans) t))

  (defun sclang-start-recording ()
    "Kill all supercollider servers."
    (interactive)
    (setq sclang-num-recording-chans
          (eval-minibuffer "number of channels to record: " (format "%d" sclang-num-recording-chans)))
    (sclang-eval-string (format "Server.default.record(%d)" sclang-num-recording-chans) t))

  (defun sclang-stop-recording ()
    "Kill all supercollider servers."
    (interactive)
    (sclang-eval-string "Server.killAll" t))

  (defun air-tiny-menu ()
      "My custom tiny menu."
      (interactive)
      (let ((tiny-menu-items
             '(("search/files" ("search/files"
                                ((?r "recent files" crux-recentf-ido-find-file)
                                 (?p "projectile" helm-projectile-switch-project)
                                 (?s "rgrep search" rgrep)
                                 (?b "goto bookmark" bookmark-jump)
                                 (?s "set bookmark" bookmark-set)
                                 (?e "ebib" ebib)
                                 (?d "dired" dired)
                                 ;; (?l "latex recipes" org-deft-latex-recipes)
                                 (?g "goto-section" air-goto-section)
                                 (?i "icicle imenu" icicle-imenu)
                                 ;; (?1 "icy on" air-turn-icicles-on)
                                 ;; (?0 "icy off" air-turn-icicles-off)
                                 )))
               ("journal/agenda" ("journal/agenda"
                                  ((?a "agenda" org-agenda-list)
                                   (?t "todos" org-todo-list)
                                   (?m "agenda menu" org-agenda)
                                   (?n "new journal entry" org-journal-at-date-from-user)
                                   (?g "goto journal entry" air-journal-goto-date))))
               ("hydra" ("hydra"
                         ((?s "search/mark/goto" hydra-search/body)
                         (?t "transpose" hydra-transpose/body)
                         (?z "zoom" hydra-zoom/body)
                         (?o "org" hydra-org/body)
                         (?j "goto journal entry" air-journal-goto-date)
                         (?m "multiple cursors" mc-hydra/body)
                         (?q "corral" hydra-corral/body)
                         )))
               )))
        (tiny-menu)))

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
  ;;;;;;;;;;;;;;;; HYDRAS
  (defhydra hydra-transpose (global-map "C-t")
    "transposing hydra"
    ("l" transpose-lines "lines")
    ("w" transpose-words "words")
    ("s" transpose-sexps "sexps")
    ("p" transpose-paragraphs "paragraphs")
    ("c" transpose-chars "characters")
    ("w" transpose-frame "windows")
    )

  (defhydra hydra-zoom (global-map "<f2>")
    "zoom"
    ("+" text-scale-increase "in")
    ("-" text-scale-decrease "out")
    ("i" text-scale-increase "in")
    ("o" text-scale-decrease "out")
    ("0" (text-scale-adjust 0) "reset")
    ("q" nil "quit" :color blue))

  (defhydra hydra-org (global-map "C-M-o" :color red :columns 3)
    "Org Mode Movements"
    ("n" outline-next-visible-heading "next heading")
    ("p" outline-previous-visible-heading "prev heading")
    ("C-p" outline-previous-visible-heading "prev heading")
    ("N" org-forward-heading-same-level "next heading at same level")
    ("P" org-backward-heading-same-level "prev heading at same level")
    ("c" org-cycle "cycle")
    ("u" outline-up-heading "up heading")
    ("i" imenu-anywhere "imenu" :exit t)
    ("I" air-goto-section "icicles goto" :exit t))

  (defhydra hydra-search (global-map "M-g" :color blue :columns 3)
    "search+goto+mark"
    ("r" helm-recentf "recent files")
    ("j" bookmark-jump "bookmark jump")
    ("P" helm-projectile-switch-project "projectile project")
    ("i" imenu-anywhere "imenu")
    ("I" air-goto-section "icicle-imenu")
    ("C-i" isearch-forward "isarch forward")
    ("s" helm-swoop "helm swoop")
    ("S" helm-multi-swoop "helm multi swoop")
    ("a" helm-projectile-ag "projectile ag")
    ("g" helm-projectile-grep "projectile grep")
    ("c" avy-goto-char "char")
    ("C" avy-goto-char-2 "char-2")
    ("C-c" goto-char "goto-char")
    ("w" avy-goto-word-1 "word")
    ("W" avy-goto-subword-1 "subword")
    ("l" avy-goto-line "avy-line")
    ("L" goto-line "goto-line")
    ("M-s" avy-goto-symbol-1 "symbol")
    ("m" easy-mark "easy-mark")
    ("p" mark-paragraph "mark-paragraph"))

  (global-set-key [S-f2] 'hydra-search/body)

  (defun corral-org-code-backward (&optional wrap-toggle)
    "Wrap double quotes around sexp, moving point to the opening double quote.

  WRAP-TOGGLE inverts the behavior of closing quote insertion compared to the
  `corral-default-no-wrap' variable."
    (interactive "P")
    (corral-command-backward ?= ?=
                             'corral-double-quotes-backward
                             'corral-double-quotes-forward
                             wrap-toggle))

  ;;;###autoload
  (defun corral-org-code-forward (&optional wrap-toggle)
    "Wrap double quotes around sexp, moving point to the closing double quote.

  WRAP-TOGGLE inverts the behavior of opening quote insertion compared to the
  `corral-default-no-wrap' variable."
    (interactive "P")
    (corral-command-forward ?= ?=
                            'corral-double-quotes-backward
                            'corral-double-quotes-forward
                            wrap-toggle))

  (defhydra hydra-corral (global-map "M-'" :columns 4)
    "Corral"
    ("(" corral-parentheses-backward "Back")
    (")" corral-parentheses-forward "Forward")
    ("[" corral-brackets-backward "Back")
    ("]" corral-brackets-forward "Forward")
    ("{" corral-braces-backward "Back")
    ("}" corral-braces-forward "Forward")
    ("'" corral-single-quotes-backward "' Back")
    ("C-'" corral-single-quotes-forward "' Forward")
    ("d" corral-double-quotes-backward "'' Back")
    ("D" corral-double-quotes-forward "'' Forward")
    ("=" corral-org-code-backward "= Back")
    ("+" corral-org-code-forward "= Forward")
    ("}" corral-braces-forward "Forward")
    ("." hydra-repeat "Repeat"))
  (global-set-key [S-f2] 'hydra-search/body)

  (defhydra mc-hydra (global-map "M-m" a:hint nil)
    "
       ^Up^            ^Down^        ^Miscellaneous^
  ----------------------------------------------
  [_p_]   Previous    [_n_]   Next    [_l_] Edit lines
  [_P_]   Skip    [_N_]   Skip    [_a_] Mark all
  [_M-p_] Unmark  [_M-n_] Unmark  [_q_] Quit"
    ("l" mc/edit-lines :exit t)
    ("a" mc/mark-all-like-this :exit t)
    ("n" mc/mark-next-like-this)
    ("N" mc/skip-to-next-like-this)
    ("M-n" mc/unmark-next-like-this)
    ("p" mc/mark-previous-like-this)
    ("P" mc/skip-to-previous-like-this)
    ("M-p" mc/unmark-previous-like-this)
    ("q" nil))
  (global-set-key [S-f2] 'hydra-search/body)

  ;;;;;;;;;;;;;;;; END HYDRAS
  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  (defun org-latex-switch-to-pdflatex ()
    "Set org mode default package and compiler vars to use pdflatex."
    (interactive)
    (setq org-latex-compiler "pdflatex")
    ;; do not use fontspec because it is incompatible with pdflatex
    (setq org-latex-packages-alist '("\\sloppy")))

  (defun org-latex-switch-to-xelatex ()
    "Set org mode default package and compiler vars to use xelatex."
    (interactive)
    (setq org-latex-compiler "xelatex")
    (setq org-latex-packages-alist
          ;; add fontspec per default, to permit use of system fonts.
          '("\\sloppy" ("" "fontspec"))))

  (defun air-tiny-menu2 ()
    "MY custom tiny menu 2: latex and other stuff"
    (interactive)
    (let ((tiny-menu-items
           '(("latex" ("latex"
                       ((?r "recipes" org-deft-latex-recipes)
                        (?c "org->xelatex" org-compile-xelatex-with-custom-headers)
                        (?C "org->pdflatex" org-compile-pdflatex-with-custom-headers)
                        (?p "pdflatex->pdf" latex-compile-file-with-pdflatex)
                        (?x "xelatex->pdf" latex-compile-file-with-xelatex))))
             ("sc lang" ("sc lang"
                         ((?s "start" sclang-start)
                          (?q "quit" sclang-stop)
                          (?r "recompile" sclang-recompile)
                          (?w "workspace" sclang-switch-to-workspace)
                          (?p "post window" sclang-show-post-buffer)
                          (?c "clear post window" sclang-clear-post-buffer))))
             ("sc server" ("sc server"
                           ((?i "set io channels" sclang-set-io-channels)
                            (?b "boot" sclang-server-boot)
                            (?q "quit server" sclang-server-quit)
                            (?k "kill all servers" sclang-kill-all-servers))))
             ("sc utils" ("sc utils"
                          ((?1 "start recording" sclang-start-recording)
                           (?0 "stop recording" sclang-stop-recording)
                           (?m "meter" sclang-server-meter)
                           (?s "scope" sclang-server-scope)
                           (?f "freqscope" sclang-server-freqscope)))))))
      (tiny-menu)))

  ;; (global-set-key (kbd "C-H-M-t") 'air-tiny-menu)
  ;; Note: I could use s-m because:
  ;; s-m is set by prelude/magit to magit commands that I do not use or plan to use directly.
  (global-set-key (kbd "H-m") 'air-tiny-menu)
  (global-set-key (kbd "H-M") 'air-tiny-menu2)
(provide 'tiny_menu_and_hydra)
;;; 031_tiny_menu_and_hydra.el ends here