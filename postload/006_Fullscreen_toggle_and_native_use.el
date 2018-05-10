;;; Fullscreen_toggle_and_native_use --- 2018-05-08 10:56:23 PM
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'Fullscreen_toggle_and_native_use)
;;; 006_Fullscreen_toggle_and_native_use.el ends here
