;;; SuperCollider-utils --- 2018-12-20 06:36:47 AM
  ;;; Commentary:
  ;;; emacs  commands for doing useful things in supercollider.
  ;;; Includes newest version of snippets library.

  ;;; Code:
  ;; (sclang-eval-string string &optional print-p)
  ;; (defun dired-get-filename (&optional localp no-error-if-not-filep)
  ;; Requires Buffers class of sc-hacks lib.

  ;; Disable switching to default SuperCollider Workspace when recompiling SClang
  (setq sclang-show-workspace-on-startup nil)

  ;; minor modes SuperCollider

  ;;; note: Replacing paredit with smartparens
  (prelude-load-require-packages
   '(smartparens rainbow-delimiters hl-sexp auto-complete))

  (require 'smartparens-config)

  ;;; paredit
  ;; NOTE: hs-minor, electric-pair: package names?

  ;; (add-hook 'sclang-mode-hook 'sclang-extegnsions-mode) ;; still problems with this
  (add-hook 'sclang-mode-hook 'smartparens-mode)
  (add-hook 'sclang-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'sclang-mode-hook 'hl-sexp-mode)
  (add-hook 'sclang-mode-hook 'hs-minor-mode)
  (add-hook 'sclang-mode-hook 'electric-pair-mode)
  ;; (add-hook 'sclang-mode-hook 'yas-minor-mode)
  (add-hook 'sclang-mode-hook 'auto-complete-mode)
  ;; (add-hook 'sclang-mode-hook 'hl-paren-mode)

  ;; Own bindings for hide-show minor mode:
  (add-hook 'sclang-mode-hook
            (lambda()
              (local-set-key (kbd "H-b b") 'hs-toggle-hiding)
              (local-set-key (kbd "H-b H-b")  'hs-hide-block)
              (local-set-key (kbd "H-b a")    'hs-hide-all)
              (local-set-key (kbd "H-b H-a")  'hs-show-all)
              (local-set-key (kbd "H-b l")  'hs-hide-level)
              (local-set-key (kbd "H-b H-l")  'hs-show-level)
              (hs-minor-mode 1)
              (visual-line-mode 1)))

  (global-set-key (kbd "H-w") 'sclang-clear-and-switch-to-workspace)

  (defun sclang-clear-and-switch-to-workspace ()
    "Shortcut for clear post window and switch to workspace."
    (interactive)
    (sclang-clear-post-buffer)
    (sclang-switch-to-workspace))

  (defun dired-load-audio-buffer (&optional preview)
    "Load file at cursor in dired to sc audio buffer.  If PREVIEW then play when loaded."
    (interactive "P")
    (sclang-eval-string
     (if preview
         (format "\"%s\",previewBuffer"
                 (dired-get-filename))
       (format "\"%s\".loadBuffer"
               (dired-get-filename)))
     t))

  (defun dired-add-startup-file (&optional preview)
    "Add the file to the list of startup files.  If PREVIEW then only test loading but do not add."
    (interactive "P")
    (let ((paths (dired-get-marked-files)))
      (dolist (path paths)
        (message path)
        (sclang-eval-string
         (if preview
             (format "\"%s\".previewCode;\n" path)
           (format "\"%s\".addCode;\n" path))
         t))))

  (eval-after-load 'dired
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key dired-mode-map (kbd "C-c C-b") 'dired-load-audio-buffer)
       (define-key dired-mode-map (kbd "C-c C-s") 'dired-add-startup-file)))

  ;; (global-set-key (kbd "H-d b") 'dired-load-audio-buffer)

  (defun org-sclang-eval-babel-block ()
    "Evaluate current babel code block as sclang code."
    (interactive)
    (let*
        ((element (cadr (org-element-at-point)))
         (code (plist-get element :value)))
      (sclang-eval-string code t)))

  (eval-after-load 'org
    '(progn
       ;; Note: This keybinding is in analogy to the default keybinding:
       ;; C-c . -> org-time-stamp
       (define-key org-mode-map (kbd "C-c C-/") 'org-sclang-eval-babel-block)))

    ;;; key chords for sclang
  (defun sclang-2-windows ()
    "Reconfigure frame to this window and sclang-post-window."
    (interactive)
    (delete-other-windows)
    (sclang-show-post-buffer))

  ;; (defun sclang-plusgt ()
  ;;   "Insert +>."
  ;;   (interactive)
  ;;   (insert "+>"))

  ;; (defun sclang-ltplus ()
  ;;   "Insert <+."
  ;;   (interactive)
  ;;   (insert "<+"))

  ;; (defun sclang-xgt ()
  ;;   "Insert *>"
  ;;   (interactive)
  ;;   (insert "*>"))

  (defun scundelify ()
    "Convert //: snippet blocks to regular style () sc blocks in document."
    (interactive)
    (save-excursion
      (goto-char (point-min))
      (while (re-search-forward "\n//:" nil t)
        (replace-match "\n\)\n//:")
        (goto-char (line-end-position 2))
        (goto-char (line-beginning-position 1))
        (insert "\(\n")
        (goto-char (line-beginning-position 1))
        (delete-blank-lines))
      (goto-char (point-min))
      (re-search-forward "\)\n//:" nil t)
      (replace-match "\n://:")))

  (defun sclang-server-plot-tree ()
    "Open plotTree for default server."
    (interactive)
    (sclang-eval-string "Server.default.plotTree"))

  (defun sclang-server-meter ()
    "Open i/o meter for default server."
    (interactive)
    (sclang-eval-string "Server.default.meter"))

  (defun sclang-server-scope ()
    "Open scope for default server."
    (interactive)
    (sclang-eval-string "Server.default.scope"))

  (defun sclang-server-freqscope ()
    "Open frequency scope for default server."
    (interactive)
    (sclang-eval-string "Server.default.freqscope"))

  (defun sclang-startupfiles-gui ()
    "Open StartupFile gui."
    (interactive)
    (sclang-eval-string "StartupFiles.gui"))

  (defun sclang-audiofiles-gui ()
    "Open AudioFiles gui."
    (interactive)
    (sclang-eval-string "AudioFiles.gui;"))

  (defun sclang-players-gui ()
    "Open Players gui."
    (interactive)
    (sclang-eval-string "PlayerGui();"))

  (defun sclang-extensions-gui ()
    "Open gui for browsing user extensions classes and methods.
    Type return on a selected item to open the file where it is defined."
    (interactive)
    (sclang-eval-string "Class.extensionsGui;"))

  (defun sclang-nevent-gui ()
    "Open gui displaying contents of current Nenvir."
    (interactive)
    (sclang-eval-string "NeventGui.gui;"))

  ;; (defhydra hydra-snippets (sclang-mode-map "C-h C-s")
  ;;   "zoom"
  ;;   ("+" text-scale-increase "in")
  ;;   ("-" text-scale-decrease "out")
  ;;   ("i" text-scale-increase "in")
  ;;   ("o" text-scale-decrease "out")
  ;;   ("0" (text-scale-adjust 0) "reset")
  ;;   ("q" nil "quit" :color blue))

  (eval-after-load 'sclang
    (progn
      ;; these are disabled by sclang-bindings:
      ;; (define-key sclang-mode-map (kbd "C-c C-p t") 'sclang-server-plot-tree)
      ;; (define-key sclang-mode-map (kbd "C-c C-p m") 'sclang-server-meter)
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; sc-hacks gui commands:
      (define-key sclang-mode-map (kbd "C-h g s") 'sclang-startupfiles-gui)
      (define-key sclang-mode-map (kbd "C-h g a") 'sclang-audiofiles-gui)
      (define-key sclang-mode-map (kbd "C-h g p") 'sclang-players-gui)
      (define-key sclang-mode-map (kbd "C-h g e") 'sclang-extensions-gui)
      (define-key sclang-mode-map (kbd "C-h g n") 'sclang-nevent-gui)
      (define-key sclang-mode-map (kbd "H-s") 'hydra-snippets/body)
      (define-key sclang-mode-map (kbd "H-S") 'hydra-sclang/body)
       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Server state visualisation utilities
      ;; TODO: Check and re-assign these commands for consistency with
      ;; default sclang commands C-c C-p x:
      (define-key sclang-mode-map (kbd "C-c P p") 'sclang-server-plot-tree)
      (define-key sclang-mode-map (kbd "C-c P m") 'sclang-server-meter)
      (define-key sclang-mode-map (kbd "C-c P s") 'sclang-server-scope)
      (define-key sclang-mode-map (kbd "C-c P f") 'sclang-server-freqscope)
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
       ;;;;;;;;;;;;;;;;;;       snippet commands      ;;;;;;;;;;;;;;;;;;
      ;; eval current snippet               M-C-x
      ;; goto next snippet                  M-n
      ;; goto previous snippet              M-p
      ;; eval previous snippet              M-P
      ;; eval next snippet                  M-N
      ;; duplicate current snippet          M-D
      ;; copy current snippet               M-C
      ;; select region of current snippet   M-R
      ;; cut current snippet                M-T
      ;; transpose snippet down             C-M-N
      ;; transpose snippet up               C-M-P

      (define-key sclang-mode-map (kbd "M-X") 'sclang-eval-current-snippet)
      (define-key sclang-mode-map (kbd "C-M-x") 'sclang-eval-current-snippet)
      (define-key sclang-mode-map (kbd "M-n") 'sclang-goto-next-snippet)
      (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
      (define-key sclang-mode-map (kbd "M-N") 'sclang-eval-next-snippet)
      (define-key sclang-mode-map (kbd "M-P") 'sclang-eval-previous-snippet)
      (define-key sclang-mode-map (kbd "M-D") 'sclang-duplicate-current-snippet)
      (define-key sclang-mode-map (kbd "M-C") 'sclang-copy-current-snippet)
      (define-key sclang-mode-map (kbd "M-R") 'sclang-region-select-current-snippet)
      (define-key sclang-mode-map (kbd "M-T") 'sclang-cut-current-snippet)
      (define-key sclang-mode-map (kbd "C-M-N") 'sclang-transpose-snippet-down)
      (define-key sclang-mode-map (kbd "C-M-P") 'sclang-transpose-snippet-up)


      ;; (define-key sclang-mode-map (kbd "M-C-.") 'sclang-duplicate-current-snippet)
      ;; (define-key sclang-mode-map (kbd "M-n") 'sclang-goto-next-snippet)
      ;; (define-key sclang-mode-map (kbd "M-N") 'sclang-eval-next-snippet)
      ;; (define-key sclang-mode-map (kbd "M-C-S-n") 'sclang-move-snippet-down)
      ;; (define-key sclang-mode-map (kbd "M-p") 'sclang-goto-previous-snippet)
      ;; (define-key sclang-mode-map (kbd "M-P") 'sclang-eval-previous-snippet)
      ;; (define-key sclang-mode-map (kbd "M-C-S-p") 'sclang-move-snippet-up)X

      (define-key sclang-mode-map (kbd "H-=") 'sclang-insert-snippet-separator+)
      (define-key sclang-mode-map (kbd "H-8") 'sclang-insert-snippet-separator*)

       ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
      ;; Miscellaneous
      (define-key sclang-mode-map (kbd "C-S-c c") 'sclang-clear-post-buffer)

      (key-chord-define sclang-mode-map "11" 'sclang-2-windows)
      ;; (key-chord-define sclang-mode-map "''" 'sclang-plusgt)
      ;; (key-chord-define sclang-mode-map ";;" 'sclang-ltplus)
      ;; (key-chord-define sclang-mode-map "\\\\" 'sclang-xgt)
      ))
(provide 'SuperCollider-utils)
;;; 016_SuperCollider-utils.el ends here
