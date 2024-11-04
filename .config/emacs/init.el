(add-to-list 'load-path
             (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path
             (expand-file-name "theme" user-emacs-directory))


(require 'nano-package)

(setq package-list
      '(ag 
         company
         bind-key
         ligature
         orderless
         treesit-auto
         markdown-mode))

;; Install packages that are not yet installed
(dolist (package package-list)
  (straight-use-package package))

;; GNU Emacs / N Λ N O Modeline
(straight-use-package
 '(nano-modeline :type git :host github :repo "rougier/nano-modeline"))

;; An Emacs minor mode for highlighting matches to the selection
(straight-use-package
 '(selection-highlight-mode :type git :host github :repo "balloneij/selection-highlight-mode"))


(require 'nano)
