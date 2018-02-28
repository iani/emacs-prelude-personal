;;; helm-swoop --- 2018-02-28 10:58:56 AM
;;; helm-swoop is broken beyond repair
;;; use helm-occur instead.
;;; Make ace-isearch use helm-occur

(global-ace-isearch-mode +1)
;; (prelude-load-require-package 'helm-swoop)
(global-set-key (kbd "C-S-s") 'helm-occur)

;;; extend ace-isearch limit to prevent premature switch to helm-occur.
(setq ace-isearch-input-length 20)

;; Make isearch use helm-occur instead of helm-swoop for ace-isearch-mode:
(defun ace-isearch-helm-swoop-from-isearch ()
  "Invoke `helm-occur' from ace-isearch.
This version uses helm-occur instead of helm-swoop,
because helm-swook seems now broken."
  (interactive)
  (let (($query (if isearch-regexp
                    isearch-string
                  (regexp-quote isearch-string))))
    (let (search-nonincremental-instead)
      (ignore-errors (isearch-exit)))
    (helm-occur)))
(provide 'helm-swoop)
;;; 012_helm-swoop.el ends here
