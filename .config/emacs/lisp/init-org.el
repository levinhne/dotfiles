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
  (set-face-attribute 'org-block nil :font "Fira Code Medium")
  (set-face-attribute 'org-block-begin-line nil :font "Fira Code Medium")
  (set-face-attribute 'org-block-end-line nil :font "Fira Code Medium")
  (flyspell-mode 1)
  (auto-fill-mode 0)))
        
(provide 'init-org)

