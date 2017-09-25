;;; Fullscreen_toggle_and_native_use --- 2017-09-25 06:02:02 AM
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'Fullscreen_toggle_and_native_use)
;;; 005_Fullscreen_toggle_and_native_use.el ends here
