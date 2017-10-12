;;; Fullscreen_toggle_and_native_use --- 2017-10-12 10:56:21 PM
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'Fullscreen_toggle_and_native_use)
;;; 006_Fullscreen_toggle_and_native_use.el ends here
