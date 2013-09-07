;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;   Nicol TAO Emacs profile
;;
;;   Sichuan University, 
;;   Alcatel-Lucent Shanghai Bell, 
;;   Redhat Beijing
;;   TP-LINK
;;
;;   <nicol@anyshare.org>  All rights reserved.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq user-full-name "Nicol TAO")
(setq user-mail-address "taozhijiang@gmail.com")

;; We store backup all the files to the directory EmacsData/auto-save-list
(add-to-list 'backup-directory-alist
			 (cons "." 
				(concat relative-dir "/EmacsData/auto-save-list/"))
)
;;(setq auto-save-list-file-prefix
;;				(concat relative-dir "/EmacsData/auto-save-list/")
;;)

;; The backspace key is broken
;; (define-key global-map "\C-h" 'backward-delete-char)
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;;First and formost, the Ctrl-Space corrupts
;;with the input methord, so bind the set-mark-command to
(global-unset-key (kbd "C-SPC"))
(global-set-key (kbd "C-q") 'set-mark-command)
(global-set-key "\C-cs" 'query-replace)
;; If we C-k at the beginning of the line, then kill the \n also
(setq-default kill-whole-line t)

;; Setup the emacs global hot key
;; Set 'C-x C-m' to close the emacs
(global-set-key "\C-x\C-m" 'save-buffers-kill-terminal)

;;Goto the definite line by the line number "C-x l"
;;(define-key ctl-x-map "l" 'goto-line)
(global-set-key "\C-xl" 'goto-line)
;;Home; to the begin of the current buffer
(global-set-key [(home)] 'beginning-of-buffer)
;;End; to the end of the current buffer
(global-set-key [(end)] 'end-of-buffer)

;;By default, the M-w can not copy things to the system clipboard
(setq x-select-enable-clipboard t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;The general apperance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Miss the startup message
(setq inhibit-startup-message t)
;;Highlight depend on the stynx
(global-font-lock-mode t)
;;Display tool & menu bar & hide scroll-bar
;;(scroll-bar-mode -1)  ;; not avaliable in our command module
;;(tool-bar-mode nil)
(menu-bar-mode nil)
;; we use F10 to toggle the display of menubar
(global-set-key [f10] 'menu-bar-mode)

(global-linum-mode 1)
;;mouse avoid your sight
(mouse-avoidance-mode 'animate)
;;Cursor do not blink
(blink-cursor-mode -1)
;;The parent blacket
(show-paren-mode t)
(setq show-paren-style 'parentheses)
;;Paste to the cursor's position, not the mouse
(setq mouse-yank-at-point t)

;;Display time & date
(display-time-mode t)
(setq display-time-24hr-format t
	  display-time-day-and-date t
	  display-time-interval 10
	  display-time-format "%y-%m-%d %a %H:%M")
(display-time)

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
;;
;; Many other settings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Every week starts from Monday
(setq calendar-week-start-day 1)
(setq calendar-location-name "北京")

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

(message " initializing for program ...")
(add-to-list 'load-path 
	(concat relative-dir "/program/"))
(require 'program)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Tools
;; erc flyspell weibo evernote tramp
;; mew
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(message  " initializing for tool ...")
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


(global-set-key [f12] 'gnus)    ;;F12 to open gnus, not directly F12
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

;; Other miscs
;; 在minibuffer里面补全M-x执行命令
(icomplete-mode)

(require 'global-keyboard-keymap)

(provide 'init-emacs)
