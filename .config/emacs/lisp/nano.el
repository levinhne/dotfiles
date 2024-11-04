;; Theming Command line options (this will cancel warning messages)
(add-to-list 'command-switch-alist '("-no-splash" . (lambda (args))))
(add-to-list 'command-switch-alist '("-debug" . (lambda (args))))

;; Theme
(require 'nano-theme)
(nano-mode)
(load-theme 'nano t)

;; Default layout
(require 'nano-layout)

;; Nano default settings
(require 'nano-defaults)

;; Org mode
(require 'nano-org)




(provide 'nano)
;;; nano.el ends here
