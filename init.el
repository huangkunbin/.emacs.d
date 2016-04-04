(when (>= emacs-major-version 24)
    (require 'package)
    (package-initialize)
    (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
    )

;; cl - Common Lisp Extension
(require 'cl)

;; Add Packages
(defvar HUANG_KUN_BIN/packages '(
               ;; --- Auto-completion ---
	       company
	       company-go
               ;; --- Better Editor ---
               hungry-delete
               swiper
               counsel
               smartparens
               ;; --- Major Mode ---
               go-mode
               ;; --- Minor Mode ---
               exec-path-from-shell
               ;; --- Themes ---
               monokai-theme
               ) "Default packages")

(setq package-selected-packages HUANG_KUN_BIN/packages)
(defun HUANG_KUN_BIN/packages-installed-p ()
    (loop for pkg in HUANG_KUN_BIN/packages
          when (not (package-installed-p pkg)) do (return nil)
          finally (return t)))
(unless (HUANG_KUN_BIN/packages-installed-p)
    (message "%s" "Refreshing package database...")
    (package-refresh-contents)
    (dolist (pkg HUANG_KUN_BIN/packages)
      (when (not (package-installed-p pkg))
        (package-install pkg))))
;; Find Executable Path on OS X
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; 关闭工具栏 tool-bar-mode 即为一个 Minor Mode
(tool-bar-mode -1)
;; 关闭文件滑动控件
(scroll-bar-mode -1)
;; 显示行号
(global-linum-mode t)
;; 更改光标的样式
(setq-default cursor-type 'bar)
;; 关闭启动帮助画面
(setq inhibit-splash-screen t)
;; 关闭缩进
(electric-indent-mode -1)
;; 更改显示字体大小 12pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 120)
;; 快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)
;; 开启全局 Company 补全
(global-company-mode t)
;; 禁止 Emacs 自动生成备份文件
(setq make-backup-files nil)
;;打开最近编辑过的文件
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)
(global-set-key "\C-x\ \C-r" 'recent-open-files)
;;开启默认全屏
(setq initial-frame-alist (quote ((fullscreen . maximized))))
;;自动括号匹配
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;;高亮当前行
(global-hl-line-mode t)
;;安装主题
(load-theme 'monokai t)

;;Golang
(require 'go-mode)
(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports)))

(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-g") 'go-goto-imports)))

(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-f") 'gofmt)))(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'go-mode-hook '(lambda ()
  (local-set-key (kbd "C-c C-k") 'godoc)))

(add-hook 'go-mode-hook (lambda ()
  (set (make-local-variable 'company-backends) '(company-go))
  (company-mode)))


