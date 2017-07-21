;;; sclang-link-folder-to-extensions --- link current folder to sc extensions

;;; Commentary:

;;; Add the folder of the present file to SC Extensions, to compile its class code.
;;; Create a symbolic link to the present folder into the
;;; Extensions folder of SuperCollider user app support dir.

;;; Code:

(defun sclang-link-folder-to-extensions (unlink-p)
  "Add the folder of the present file to SC Extensions, to compile it.
Create a symbolic link to the present folder into the
Extensions folder of SuperCollider user app support dir.
If UNLINK-P is not nil, then delete the link instead."
  (interactive "P")
  (let* ((lib-path (file-name-directory (buffer-file-name)))
         (lib-name (file-name-nondirectory (directory-file-name lib-path)))
         (link-path (concat
                     (file-truename "~/Library/Application Support/SuperCollider/Extensions/")
                     lib-name)))
    (message lib-path)
    (message lib-name)
    (message link-path)
   (if unlink-p
       ()))
  )

(provide '23_sclang-link-folder-to-extensions)
;;; 23_sclang-link-folder-to-extensions.el ends here
