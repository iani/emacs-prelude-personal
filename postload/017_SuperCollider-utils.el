;;; SuperCollider-utils --- 2018-02-28 04:14:10 PM
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
  "Blah."
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

(defun sclang-get-current-snippet ()
  "Return region between //: comments in sclang, as string.
If the beginning of line is '//:+', then fork the snippet as routine.
If the beginning of line is '//:*', then wrap the snippet in loop and fork."
  (save-excursion
    (goto-char (line-end-position)) ;; fix when starting from point-min
    (let (
          (snippet-begin (search-backward-regexp "^//:" nil t))
          snippet-end
          snippet
          snippet-head
          (prefix ""))
      (unless snippet-begin
        (setq snippet-begin (point-min))
        (setq prefix "//:\n"))
      (setq sclang-snippet-is-routine nil)
      (setq sclang-snippet-is-loop nil)
      (goto-char snippet-begin)
      (setq snippet-head (buffer-substring-no-properties (point) (+ 4 (point))))
      (if (equal snippet-head "//:+") (setq sclang-snippet-is-routine t))
      (if (equal snippet-head "//:*") (setq sclang-snippet-is-loop t))
      (goto-char (line-end-position))
      (setq snippet-end (search-forward-regexp "^//:" nil t))
      (if snippet-end
          (setq snippet-end (line-beginning-position))
        (setq snippet-end (point-max)))
      (concat prefix
              (buffer-substring-no-properties snippet-begin snippet-end)))))

(defun sclang-cut-current-snippet ()
  "Return region between //: comments in sclang, as string, and cut it out."
  (interactive)
  (save-excursion
    (goto-char (line-end-position)) ;; fix when starting from point-min
    (let (
          (snippet-begin (search-backward-regexp "^//:" nil t))
          snippet-end
          snippet
          (prefix ""))
      (unless snippet-begin
        (setq snippet-begin (point-min))
        (setq prefix "//:\n"))
      (goto-char (line-end-position))
      (setq snippet-end (search-forward-regexp "^//:" nil t))
      (if snippet-end
          (setq snippet-end (line-beginning-position))
        (setq snippet-end (point-max)))
      (setq snippet (concat prefix
                            (buffer-substring-no-properties snippet-begin snippet-end)))
      (kill-region snippet-begin snippet-end))))

(defun sclang-transpose-snippet-down ()
  "Transpose this snippet with the one following it."
  (interactive)
  (sclang-cut-current-snippet)
  (sclang-goto-next-snippet)
  (insert "\n")
  (yank)
  (delete-blank-lines)
  (re-search-backward "^//:")
  (goto-char (line-end-position 2)))

(defun sclang-transpose-snippet-up ()
  "Transpose this snippet with the one preceding it."
  (interactive)
  (sclang-cut-current-snippet)
  (re-search-backward "^//:")
  (yank)
  (re-search-backward "^//:")
  (goto-char (line-end-position 2)))

(defun sclang-eval-current-snippet ()
  "Evaluate the current snippet in sclang.
A snippet is a block of code enclosed between comments
starting at the beginning of line and with a : following immediately after '//'.
If the beginning of line is '//:+', then fork the snippet as routine.
If the beginning of line is '//:*', then wrap the snippet in loop and fork."
  (interactive)
  (let* (sclang-snippet-is-routine
         sclang-snippet-is-loop
         (snippet (sclang-get-current-snippet)))
    (if sclang-snippet-is-routine
        (setq snippet (format "{\n %s\n }.fork" snippet)))
    (if sclang-snippet-is-loop
        (setq snippet (format "{\n loop {\n %s \n} \n }.fork" snippet)))
    (sclang-eval-string snippet t)))

(defun sclang-goto-next-snippet ()
  "Go to the next snippet."
  (interactive)
  (goto-char (sclang-end-of-snippet))
  (goto-char (line-end-position 2))
  (goto-char (line-beginning-position)))

(defun sclang-goto-previous-snippet ()
  "Go to the previous snippet."
  (interactive)
  (goto-char (line-end-position))
  (let ((pos (search-backward-regexp "^//:" nil t)))
    (if (and pos (> pos 1)) (goto-char (1- pos)))
    (setq pos (search-backward-regexp "^//:" nil t))
    (cond
     (pos
      (goto-char pos)
      (goto-char (1+ (line-end-position)))
      (goto-char (line-beginning-position)))
     (t
      (goto-char (point-min))))
    ;; (re-search-backward "^//:")
    ))

(defun sclang-eval-next-snippet ()
  "Go to the next snippet and evaluate it."
  (interactive)
  (sclang-goto-next-snippet)
  (sclang-eval-current-snippet))

(defun sclang-eval-previous-snippet ()
  "Go to the previous snippet and evaluate it."
  (interactive)
  (sclang-goto-previous-snippet)
  (sclang-eval-current-snippet))

(defun sclang-duplicate-current-snippet ()
  "Insert a copy the current snippet below itself."
  (interactive)
  (let ((snippet (sclang-get-current-snippet)))
    (goto-char (line-end-position))
    (goto-char (sclang-end-of-snippet))
    (if (eq (point) (point-max)) (insert "\n"))
    (insert snippet)))

(defun sclang-copy-current-snippet ()
  "Copy the current snippet into the kill ring."
  (interactive)
  (let ((snippet (sclang-get-current-snippet)))
    (kill-new snippet)))

(defun sclang-region-select-current-snippet ()
  "Select region between //: comments in sclang."
  (save-excursion
    (goto-char (line-end-position)) ;; fix when starting from point-min
    (let (
          (snippet-begin (search-backward-regexp "^//:" nil t))
          snippet-end
          snippet
          snippet-head)
      (unless snippet-begin
        (setq snippet-begin (point-min)))
      (goto-char snippet-begin)
      (goto-char (line-end-position))
      (setq snippet-end (search-forward-regexp "^//:" nil t))
      (if snippet-end
          (setq snippet-end (line-beginning-position))
        (setq snippet-end (point-max)))
      (goto-char snippet-begin)
      (push-mark snipet-end)
      (setq mark-active t))))

(defun sclang-cut-current-snippet ()
  "Kill the current snippet, storing it in kill-ring."
  (sclang-region-select-current-snippet)
  (kill-region (mark) (point)))

(defun sclang-end-of-snippet ()
  "Return the point position of the end of the current snippet."
  (save-excursion
    (let ((pos (search-forward-regexp "^//:" nil t)))
      (if pos (line-beginning-position) (point-max)))))

(defun sclang-beginning-of-snippet ()
  "Return the point position of the beginning of the current snippet."
  (save-excursion
    (goto-char (line-end-position))
    (let ((pos (search-backward-regexp "^//:" nil t)))
      (if pos pos (point-min)))))

(defun sclang-insert-snippet-separator (&optional before)
  "Insert snippet separator //: at beginning of line."
  (interactive "P")
  (cond
   (before
    (goto-char (line-beginning-position))
    (insert "//:\n"))
   (t
    (goto-char (line-end-position))
    (insert "\n//:"))
   ))

(defun sclang-insert-snippet-separator+ (&optional before)
  "Insert snippet separator //:+ at beginning of line."
  (interactive "P")
  (cond (before
         (goto-char (line-beginning-position))
         (insert "//:+\n"))
        (t
         (goto-char (line-end-position))
         (insert "\n//:+"))
        ))

(defun sclang-insert-snippet-separator* (&optional before)
  "Insert snippet separator //:* at beginning of line."
  (interactive "P")
  (cond (before
         (goto-char (line-beginning-position))
         (insert "//:*\n"))
        (t
         (goto-char (line-end-position))
         (insert "\n//:*"))
        ))

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
  (sclang-eval-string "AudioFiles.gui"))

(defun sclang-players-gui ()
  "Open Players gui."
  (interactive)
  (sclang-eval-string "PlayerGui.gui"))

(defun sclang-extensions-gui ()
  "Open gui for browsing user extensions classes and methods.
  Type return on a selected item to open the file where it is defined."
  (interactive)
  (sclang-eval-string "Class.extensionsGui;"))

(defun sclang-nevent-gui ()
  "Open gui displaying contents of current Nenvir."
  (interactive)
  (sclang-eval-string "NeventGui.gui;"))

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
;;; 017_SuperCollider-utils.el ends here
