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


(provide 'init-dashboard)
