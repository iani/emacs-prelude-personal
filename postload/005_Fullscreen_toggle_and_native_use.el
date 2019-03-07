;;; Fullscreen_toggle_and_native_use --- 2019-03-07 03:41:13 PM
;;; Commentary:
;;; enable native fullscreen mode and define key for toggling.

;;; Code:
(setq ns-use-native-fullscreen nil)
(global-set-key (kbd "H-t") 'toggle-frame-fullscreen)
(provide 'Fullscreen_toggle_and_native_use)
;;; 005_Fullscreen_toggle_and_native_use.el ends here
