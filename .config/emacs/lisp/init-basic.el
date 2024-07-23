(setq inhibit-startup-message t)
(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(menu-bar-mode -1)            ; Disable the menu bar
(global-visual-line-mode 1)


(set-face-attribute 'default nil
                    :family "Fira Code"
                    :height 100
                    :weight 'medium)

(set-face-attribute 'variable-pitch nil
                    :family "Gelasio" 
                    :height 110)


(provide 'init-basic)

