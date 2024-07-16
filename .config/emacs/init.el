(add-to-list 'load-path "~/.config/emacs/lisp/")
(require 'straight)

(setq inhibit-startup-message t)
(setq-default line-spacing 0.3)

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

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-startup-banner 'official)  ;; Sử dụng logo Emacs chính thức
(setq dashboard-items '((recents  . 5)     ;; Hiển thị 5 tệp tin gần đây
                        (projects . 5)     ;; Hiển thị 5 dự án gần đây
                        (agenda . 5)))     ;; Hiển thị 5 sự kiện từ lịch

(setq dashboard-set-heading-icons t)       ;; Hiển thị biểu tượng tiêu đề
(setq dashboard-set-file-icons t)          ;; Hiển thị biểu tượng tệp tin
;(setq dashboard-center-content t)          ;; Căn giữa nội dung dashboard

;; Install and configure Evil
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))


(use-package which-key
  :init
    (which-key-mode 1)
  :diminish
  :config
  (setq which-key-side-window-location 'bottom
	  which-key-sort-order #'which-key-key-order-alpha
	  which-key-allow-imprecise-window-fit nil
	  which-key-sort-uppercase-first nil
	  which-key-add-column-padding 1
	  which-key-max-display-columns nil
	  which-key-min-display-lines 6
	  which-key-side-window-slot -10
	  which-key-side-window-max-height 0.25
	  which-key-idle-delay 0.8
	  which-key-max-description-length 25
	  which-key-allow-imprecise-window-fit nil
	  which-key-separator " → " ))

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

(use-package window-margin
  :ensure t
  :config
  (window-margin-mode 1))

(setq-default window-margin-width-left 5)
(setq-default window-margin-width-right 5)
(add-hook 'window-margin-mode-hook (lambda () (window-margin-mode 1)))

;; Install and configure doom-modeline
(use-package doom-modeline
  :ensure t
  :hook (after-init . doom-modeline-mode)
  :config
  ;; Optional: Configure doom-modeline
  (setq doom-modeline-height 15
        doom-modeline-bar-width 3
        doom-modeline-minor-modes nil
        doom-modeline-icon t  ; Set to nil if you don't want icons
        doom-modeline-major-mode-icon t
        doom-modeline-buffer-file-name-style 'truncate-upto-root))

;; Install and configure all-the-icons if you want icons in the modeline
(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)
  :config
  ;; Install the icons if necessary
  (unless (file-directory-p (concat (getenv "HOME") "/.local/share/icons"))
    (all-the-icons-install-fonts t)))

;; Install and configure Org-mode
(use-package org
  :ensure t
  :config
  ;; Basic configuration for Org-mode
  (setq org-startup-indented t
        org-hide-leading-stars t
        org-pretty-entities t
        org-startup-with-inline-images t
        org-startup-with-latex-preview t
        org-directory "~/org"  ;; Set your Org files directory
        org-default-notes-file (concat org-directory "/notes.org"))

  ;; Keybindings for Org-mode
  (global-set-key (kbd "C-c c") 'org-capture)
  (global-set-key (kbd "C-c a") 'org-agenda)
  (global-set-key (kbd "C-c l") 'org-store-link))

(add-hook 'org-mode-hook (lambda ()
                           (visual-line-mode 1)
                           (org-indent-mode 1)
                           (variable-pitch-mode 1)
                           (setq line-spacing 0.2)
                           (set-face-attribute 'org-level-1 nil :height 1.2 :weight 'bold)
                           (set-face-attribute 'org-level-2 nil :height 1.1 :weight 'bold)
                           (set-face-attribute 'org-level-3 nil :height 1.05 :weight 'bold)
                           (flyspell-mode 1)
                           (auto-fill-mode 0)))

(set-face-attribute 'variable-pitch nil
                    :family "Gelasio" 
                    :height 110)
