;;; Fullscreen_toggle_and_native_use --- 2017-07-22 04:30:57 PM
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'Fullscreen_toggle_and_native_use)
;;; 003_Fullscreen_toggle_and_native_use.el ends here
