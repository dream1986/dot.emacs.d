;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Nicol TAO Emacs profile
;;   陶治江
;;   Sichuan University, 
;;   Alcatel-Lucent Shanghai Bell, 
;;   Redhat Beijing
;;   TP-LINK
;;
;;   <nicol@anyshare.org>  All rights reserved.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "taozhijiang")
(setq user-mail-address "taozhijiang@gmail.com")

;; Global Key Prefix Define
;; 添加C-x C-c C-t两种键盘映射
;; C-c
(define-prefix-command 'ctl-c-map)
(global-set-key (kbd "C-c") 'ctl-c-map)
;; C-t
(global-unset-key (kbd "C-t"))
(define-prefix-command 'ctl-t-map)
(global-set-key (kbd "C-t") 'ctl-t-map)

;; We store backup all the files to the directory EmacsData/auto-save-list
(add-to-list 'backup-directory-alist
			 (cons "." 
				(concat relative-dir "/EmacsData/auto-save-list/"))
)

;; The backspace key is broken
;; (define-key global-map "\C-h" 'backward-delete-char)
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;First and formost, the Ctrl-Space corrupts
;;with the input methord, so bind the set-mark-command to
(global-unset-key (kbd "C-SPC"))               ;;选择标记开始
(global-set-key (kbd "C-q") 'set-mark-command)
(global-set-key "\C-cs" 'query-replace)        ;;询问式查找替换
(setq-default kill-whole-line t)               ;;连带删除整行的结尾换行符

;; Set 'C-x C-m' to close the emacs
(global-set-key "\C-x\C-m" 'save-buffers-kill-terminal)

;;Goto the definite line by the line number "C-x l"
(define-key ctl-x-map "l" 'goto-line)
(global-set-key [(home)] 'beginning-of-buffer)  ;; HOME  END 跳转到缓冲区的开头结尾
(global-set-key [(end)] 'end-of-buffer)

;;By default, the M-w can not copy things to the system clipboard
(setq x-select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;The general apperance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-startup-message t)                ;;缩减启动信息
(global-font-lock-mode t)                       ;;打开语法高亮显示
;; 关闭滚动条，关闭工具栏，打开菜单栏
;;Display tool & menu bar & hide scroll-bar
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode 1)
;; we use F8 to toggle the display of menubar
(global-set-key [f8] 'menu-bar-mode)

(global-linum-mode 1)
;;mouse avoid your sight
(mouse-avoidance-mode 'animate)
;;Cursor do not blink
(blink-cursor-mode -1)
;;The parent blacket
(show-paren-mode t)
(setq show-paren-style 'parentheses)
(setq mouse-yank-at-point t)                   ;;粘贴在光标处，而不是鼠标处

;;Display time & date
(display-time-mode t)
(setq display-time-24hr-format t
	  display-time-day-and-date t
	  display-time-interval 10
	  display-time-format "%y-%m-%d %a %H:%M")
(display-time)
;; Every week starts from Monday
(setq calendar-week-start-day 1)
(setq calendar-location-name "北京")

(setq chinese-calendar-celestial-stem
["甲" "乙" "丙" "丁" "戊" "已" "庚" "辛" "壬" "癸"])
(setq chinese-calendar-terrestrial-branch
["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

(setq calendar-latitude +39.54
	  calendar-longitude +116.28
	  calendar-location-name "北京")
 
;;Display image, not show code
(setq auto-image-file-mode t)

;;Global tab settings
(setq default-tab-width 4)
(setq c-basic-offset 4)
(setq c++-basic-offset 4)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Many other settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Bookmark file
(setq bookmark-default-file
	(concat relative-dir "/EmacsData/emacs.bmk"))
(setq bookmark-save-flag 1) ;;save when set one

;; Diary file
(setq diary-file 
	(concat relative-dir "/EmacsData/diary")
	diary-mail-addr "taozhijiang@gmail.com"
	org-agenda-include-diary t)

;; Yes No -> y n
(fset 'yes-or-no-p 'y-or-n-p)

;;Very important, for system larger font
(if window-system
	(progn
	  (set-face-font 'default
			   "-unknown-DejaVu Sans Mono-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1")
	  (set-fontset-font (frame-parameter nil 'font)
			   'han (font-spec :family "WenQuanYi Micro Hei" :size 13))
	  (set-fontset-font (frame-parameter nil 'font)
			   'symbol (font-spec :family "WenQuanYi Micro Hei" :size 13))
	  (set-fontset-font (frame-parameter nil 'font)
			   'cjk-misc (font-spec :family "WenQuanYi Micro Hei" :size 13))
	)
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Program
;; auto-complete yasnippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message " Begin initializing for program ...")
(add-to-list 'load-path 
	(concat relative-dir "/program/"))
(require 'program)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tools
;; erc flyspell weibo evernote tramp
;; mew
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message  " Begin initializing for tool ...")
(add-to-list 'load-path
	(concat relative-dir "/tool/"))
(require 'tool)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc
;; many others
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message " initializing for misc ...")
(add-to-list 'load-path 
	(concat relative-dir "/misc/"))
(require 'misc)


;; misc is too large right now
;; separate and create misc_2
(message " initializing for misc ...")
(add-to-list 'load-path 
	(concat relative-dir "/a_misc/"))
(require 'a_misc)

;; Well, this full screan do make us feel very well, especaill small screen notebook
;; It is really cool
(defun toggle-fullscreen (&optional f)
  (interactive)
  (let ((current-value (frame-parameter nil 'fullscreen)))
       (set-frame-parameter nil 'fullscreen
			(if (equal 'fullboth current-value)
				(if (boundp 'old-fullscreen) old-fullscreen nil)
				    (progn (setq old-fullscreen current-value)
                                       'fullboth)))))

;; assosciate current buffer with file, then
;; edit this file as super user
(defun wenshan-edit-current-file-as-root ()
  "Edit the file that is associated with the current buffer as root"
  (interactive)
  (if (buffer-file-name)
      (progn
        (setq file (concat "/sudo:root@localhost:" (buffer-file-name)))
        (find-file file))
    (message "Current buffer does not have an associated file.")))
(global-set-key "\C-xm" 'wenshan-edit-current-file-as-root)


(global-set-key [f10] 'gnus)    ;;F12 to open gnus, not directly F12
(global-set-key [f11] 'toggle-fullscreen)

;; Delete, truely mv the fiel to trushbin
;; Also, do not save some really rubbish
(setq delete-by-moving-to-trash t
	  system-trash-exclude-matches '("#[^/]+#$" ".*~$" "\\.emacs\\.desktop.*")
	  system-trash-exclude-paths '("/tmp"))


;;    find -name "*~" -print0 | xargs -0 rm
;;    find -name "*~" -exec rm {} \;
(setq backup-by-copying t ; That means we do with file, not symbol-link
	  delete-old-versions t ; 自动删除旧的备份文件
	  kept-new-versions 3 ; 保留最近的6个备份文件
	  kept-old-versions 2 ; 保留最早的2个备份文件
	  version-control t) ; 多次备份

;; show images
(auto-image-file-mode t)
(setq w3m-default-display-inline-images t) 
(setq w3m-use-cookies t)
(setq w3m-display-inline-image t) 

(require 'global-keyboard-keymap)

(require 'emacs-code-patch)

(provide 'init-emacs)
