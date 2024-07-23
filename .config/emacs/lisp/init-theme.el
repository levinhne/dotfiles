;; Install and configure doom-themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dracula t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; Install and configure doom-modeline
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  ;; Optional: Configure doom-modeline
  (setq doom-modeline-height 22
        doom-modeline-support-imenu t
        doom-modeline-bar-width 3
        doom-modeline-minor-modes nil
        doom-modeline-icon t  ; Set to nil if you don't want icons
        doom-modeline-major-mode-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-root))

(provide 'init-theme)
