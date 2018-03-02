;;; tiny_menu --- 2018-03-02 06:19:42 PM
;;; Commentary:

;; test code for using tiny-menu
;; from: https://blog.aaronbieber.com/2016/07/31/org-navigation-revisited.html

;;; Code:

;; (let ((projectile-switch-project-action 'projectile-find-file))
;;   (projectile-switch-project-by-name "/Users/iani/BitTorrent Sync/000WORKFILES/"))

(prelude-load-require-package 'tiny-menu)

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
                              ((?g "goto-section" air-goto-section)
                               (?r "recent files" crux-recentf-ido-find-file)
                               (?p "projectile" helm-projectile-switch-project)
                               (?d "dired" dired)
                               (?g "goto bookmark" bookmark-jump)
                               (?s "set bookmark" bookmark-set)
                               (?1 "icy on" air-turn-icicles-on)
                               (?0 "icy off" air-turn-icicles-off))))
             ("journal/agenda" ("journal/agenda"
                                ((?a "agenda" org-agenda-list)
                                 (?t "todos" org-todo-list)
                                 (?m "agenda menu" org-agenda)
                                 (?n "new journal entry" org-journal-at-date-from-user)
                                 (?g "goto journal entry" air-journal-goto-date))))
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
;; (defun air-tiny-menu ()
;;     "My custom tiny menu."
;;     (interactive)
;;     (let ((tiny-menu-items
;;            '(("agenda" ("agenda"
;;                         ((?a "agenda" org-agenda-list)
;;                          (?A "agenda menu" org-agenda)
;;                          (?t "todo" org-todo-list))))
;;              ("workfiles" ("workfiles"
;;                            ((?c "commander" projectile-commander-workfiles)
;;                             ;; (?s "ag" projectile-ag-workfiles)
;;                             (?v "magit" projectile-vc-workfiles)
;;                             (?f "find file" projectile-find-file-workfiles)
;;                             (?r "recent" projectile-recent-files-workfiles)
;;                             (?d "dired" projectile-dired-workfiles)
;;                             (?D "root dired" projectile-root-dired-workfiles))))
;;              ("projects" ("projects"
;;                           ((?c "commander" projectile-commander-projects)
;;                            ;; (?s "ag" projectile-ag-projects)
;;                            (?v "magit" projectile-vc-projects)
;;                            (?f "find file" projectile-find-file-projects)
;;                            (?r "recent" projectile-recent-files-projects)
;;                            (?d "dired" projectile-dired-projects)
;;                            (?D "root dired" projectile-root-dired-projects))))
;;              ("files" ("files"
;;                        ((?i "icy imenu" icicle-imenu)
;;                         (?l "org jump local" air-refile-goto-current-buffer)
;;                         (?r "recent files" helm-recentf)
;;                         (?j "projects refile jump" org-jump-to-refile-target)
;;                         (?w "Workfiles find file" projectile-find-file-workfiles)
;;                         (?W "Workfiles projectile commander" projectile-commander-workfiles))))
;;              ("stuff"   ("stuff"
;;                          ((?t "Tag"     org-tags-view)
;;                           (?i "ID"      air-org-goto-custom-id)
;;                           (?k "Keyword" org-search-view)
;;                           (?s "SuperCollider" sclang-start))))
;;              ("icicles"   ("icicles"
;;                            ((?1 "icy on" air-turn-icicles-on)
;;                             (?0 "icy off" air-turn-icicles-off))))
;;              ("org-links"    ("Links"
;;                               ((?c "Capture"   org-store-link)
;;                                (?l "Insert"    org-insert-link)
;;                                (?i "Custom ID" air-org-insert-custom-id-link)))))))
;;       (tiny-menu)))

;; (setq tiny-menu-items
;;       '(("org-things"   ("Things"
;;                          ((?t "Tag"     org-tags-view)
;;                           (?i "ID"      air-org-goto-custom-id)
;;                           (?k "Keyword" org-search-view)
;;                           (?l "Refile Goto Local" air-refile-goto-current-buffer)
;;                           )))
;;         ("org-links"    ("Links"
;;                          ((?c "Capture"   org-store-link)
;;                           (?l "Insert"    org-insert-link)
;;                           (?i "Custom ID" air-org-insert-custom-id-link))))))

;; (global-set-key (kbd "C-H-M-t") 'air-tiny-menu)
;; s-m is set by prelude/magit to magit commands that I do not use or plan to use directly.
(global-set-key (kbd "H-m") 'air-tiny-menu)
(provide 'tiny_menu)
;;; 028_tiny_menu.el ends here
