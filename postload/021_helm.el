;; Add helm functionality to:
;; 1. Ensure that helm-browse-project will find .git root dir and update cache
;; 2. Add actions to helm to org-capture on the selected file.

;; Current helm-browse-project does not go up to .git root
;; Behavior is erratic. Goes to .git root after repeating 2 times 
;; (global-set-key (kbd "C-c C-h p") 'helm-browse-project) 

;; Modified from helm-browse-project
(defun helm-browse-workfiles ()
  "Browse workfiles root directory with helm-project."
  (interactive)
  (helm-browse-project-root '(4)))

(defun helm-browse-project-root (arg)
  "Preconfigured helm to browse projects FROM .git ROOT.
Adapted from helm-browse-project.
Browse files and see status of project with its vcs.
Only HG and GIT are supported for now.
Fall back to `helm-browse-project-find-files'
if current directory is not under control of one of those vcs.
With a prefix ARG browse files recursively, with two prefix ARG
rebuild the cache.
If the current directory is found in the cache, start
`helm-browse-project-find-files' even with no prefix ARG.
NOTE: The prefix ARG have no effect on the VCS controlled directories.

Needed dependencies for VCS:
<https://github.com/emacs-helm/helm-ls-git>
and
<https://github.com/emacs-helm/helm-ls-hg>
and
<http://melpa.org/#/helm-ls-svn>."
  (interactive "P")
  (cond ((and (require 'helm-ls-git nil t)
              (fboundp 'helm-ls-git-root-dir)
              (helm-ls-git-root-dir))
         (helm-ls-git-ls))
        ((and (require 'helm-ls-hg nil t)
              (fboundp 'helm-hg-root)
              (helm-hg-root))
         (helm-hg-find-files-in-project))
        ((and (require 'helm-ls-svn nil t)
              (fboundp 'helm-ls-svn-root-dir)
              (helm-ls-svn-root-dir))
         (helm-ls-svn-ls))
        (t (let ((cur-dir (helm-browse-project-get-git-root-dir
                           (if arg
                               iz-log-dir ;; defined in org-notes
                             (helm-current-directory)))))
             (setq arg '(4))
             (if (or arg (gethash cur-dir helm--browse-project-cache))
                 (helm-browse-project-find-files cur-dir (equal arg '(16)))
                 (helm :sources (helm-browse-project-build-buffers-source cur-dir)
                       :buffer "*helm browse project*"))))))

;; Modifying helm function to look for .git folder
(defun helm-browse-project-get-git-root-dir (directory)
  "Search in directory or its superdirectories for .git folder.
Adapted from helm-browse-project-get--root-dir."
  (cl-loop with dname = (file-name-as-directory directory)
           while (and dname (not
                             (file-expand-wildcards (concat dname ".git"))
                             ;; (gethash dname helm--browse-project-cache)
                             ))
           if (file-remote-p dname)
           do (setq dname nil) else
           do (setq dname (helm-basedir (substring dname 0 (1- (length dname)))))
           finally return (or dname (file-name-as-directory directory))))


(defun helm-org-capture-in-file (_ignore)
  (let* ((helm--reading-passwd-or-string t)
         (file (car (helm-marked-candidates))))
    (find-file file)
    (org-log-here)))

(defun helm-org-add-to-agenda (&optional _ignore1 _ignore2)
  (let* ((helm--reading-passwd-or-string t)
         (file (car (helm-marked-candidates))))
    (add-to-list 'org-agenda-files file)))

(defun helm-org-set-agenda (&optional _ignore1 _ignore2)
  (let* ((helm--reading-passwd-or-string t))
    (setq org-agenda-files (helm-marked-candidates))))

(defun helm-org-capture-in-buffer (buffer-or-name &optional other-window)
  "Switch to org mode buffer and capture in it.
Adapted from helm-switch-to-buffers."
  (switch-to-buffer buffer-or-name)
  (org-log-here))

;; Customize helm-type-file-actions: Add org-capture action
(setq helm-type-file-actions
      '(("Find file" . helm-find-many-files)
        ("Org-capture in file" . helm-org-capture-in-file)
        ("Add file to org agenda" . helm-org-add-to-agenda)
        ("Set org agenda to file(s)" . helm-org-set-agenda)
        ("Find file as root" . helm-find-file-as-root)
        ("Find file other window" . helm-find-files-other-window)
        ("Find file other frame" . find-file-other-frame)
        ("Open dired in file's directory" . helm-open-dired)
        ("Insert as org link" . helm-files-insert-as-org-link)
        ("Grep File(s) `C-u recurse'" . helm-find-files-grep)
        ("Zgrep File(s) `C-u Recurse'" . helm-ff-zgrep)
        ("Pdfgrep File(s)" . helm-ff-pdfgrep)
        ("Checksum File" . helm-ff-checksum)
        ("Ediff File" . helm-find-files-ediff-files)
        ("Ediff Merge File" . helm-find-files-ediff-merge-files)
        ("Etags `M-., C-u reload tag file'" . helm-ff-etags-select)
        ("View file" . view-file)
        ("Insert file" . insert-file)
        ("Add marked files to file-cache" . helm-ff-cache-add-file)
        ("Delete file(s)" . helm-delete-marked-files)
        ("Copy file(s) `M-C, C-u to follow'" . helm-find-files-copy)
        ("Rename file(s) `M-R, C-u to follow'" . helm-find-files-rename)
        ("Symlink files(s) `M-S, C-u to follow'" . helm-find-files-symlink)
        ("Relsymlink file(s) `C-u to follow'" . helm-find-files-relsymlink)
        ("Hardlink file(s) `M-H, C-u to follow'" . helm-find-files-hardlink)
        ("Open file externally (C-u to choose)" . helm-open-file-externally)
        ("Open file with default tool" . helm-open-file-with-default-tool)
        ("Find file in hex dump" . hexl-find-file)))

(setq helm-type-buffer-actions
      '(("Switch to buffer(s)" . helm-switch-to-buffers)
       ("Org-capture in buffer)" . helm-org-capture-in-buffer)
       ("Add file to org agenda" . helm-org-add-to-agenda)
       ("Set org agenda to file(s)" . helm-org-set-agenda)
       ("Switch to buffer(s) other window `C-c o'" . helm-switch-to-buffers-other-window)
       ("Switch to buffer other frame `C-c C-o'" . switch-to-buffer-other-frame)
       ("Query replace regexp `C-M-%'" . helm-buffer-query-replace-regexp)
       ("Query replace `M-%'" . helm-buffer-query-replace)
       ("View buffer" . view-buffer)
       ("Display buffer" . display-buffer)
       ("Grep buffers `M-g s' (C-u grep all buffers)" . helm-zgrep-buffers)
       ("Multi occur buffer(s) `C-s'" . helm-multi-occur-as-action)
       ("Revert buffer(s) `M-U'" . helm-revert-marked-buffers)
       ("Insert buffer" . insert-buffer)
       ("Kill buffer(s) `M-D'" . helm-kill-marked-buffers)
       ("Diff with file `C-='" . diff-buffer-with-file)
       ("Ediff Marked buffers `C-c ='" . helm-ediff-marked-buffers)
       ("Ediff Merge marked buffers `M-='" .
        #[257 "\300\301\"\207"
              [helm-ediff-marked-buffers t]
              4 "\n\n(fn CANDIDATE)"])))

(global-set-key (kbd "C-c C-h b") 'helm-browse-project-root)
(global-set-key (kbd "C-c C-h w") 'helm-browse-workfiles)
