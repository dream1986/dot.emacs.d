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
;;
;;   tools.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'tool)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; erc, Emacs IRC Client
;; version 5.3
;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path 
	(concat relative-dir "/tool/erc-5.3/"))
(require 'erc) 

;; Automatic show the info
(setq erc-auto-query 'buffer)

(setq erc-modules                       ;加载的模块
      '(
        autojoin                        ;自动加入
        button                          ;按钮
        completion                      ;补全
        dcc                             ;文件传输
        fill                            ;填充
        irccontrols                     ;IRC控制
        list                            ;列表
        match                           ;匹配
        menu                            ;菜单
        move-to-prompt                  ;移动到提示符
        netsplit                        ;发觉Netsplit
        networks                        ;网络
        noncommands                     ;不显示非IRC命令
        readonly                        ;显示行只读
        ring                            ;输入历史
        services                        ;自动鉴别
        smiley                          ;笑脸转换
        sound                           ;声音
        stamp                           ;时间戳
        track                           ;跟踪
        unmorse                         ;转换莫尔斯码
 ))


(global-set-key "\C-cef" (lambda () (interactive)
						   (erc :server "irc.devel.redhat.com" 
								:port 6667
								:nick "nicol")))

(require 'erc-join)
(erc-autojoin-mode 1)
(setq erc-autojoin-channels-alist
	  '(("moorcock.freenode.net" "#emacs" "#emacs-cn" "#ubuntu-cn")
       ("irc.devel.redhat.com" "#kernel-qe" "#eng-china" "#kernel-qa-beijing")))

(setq erc-nick "nicol"
	  erc-away-nickname "Nicol{Away}"
	  erc-user-full-name "Nicol TAO")
(setq erc-server-auto-reconnect t)
(setq erc-prompt ">>")
(setq erc-track-position-in-mode-line t)

(require 'erc-log)
(setq erc-log-channels-directory 
	(concat relative-dir "/EmacsData/erc/" ))
(erc-log-enable)
(setq erc-save-buffer-on-part t
	  erc-log-file-coding-system 'utf-8
	  erc-log-write-after-sent t
	  erc-log-write-after-insert t)

(unless (file-exists-p erc-log-channels-directory)
   (mkdir erc-log-channels-directory t))

;; Display the user list
(require 'erc-nicklist)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;  org
;;  Emacs already built in
;;  6.33
;;;;;;;;;;;;;;;;;;;;;;;;;;

;; the file use .org extensions, fall into Org mode
;; all the file can fall into Org with the first line
;; MY PROJECTS    -*- mode: org; -*-
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
;; org binding keys
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
 (transient-mark-mode 1)  ;; default

;;;;;;;;;;;;;;;;;;;;;;;;
;; mew
;; email client
;;
;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;(autoload 'mew "mew" nil t)
;;(autoload 'mew-send "mew" nil t)
;;;; We really need this, for the 126mail use starttls, we also need to install gnutls
;;(setq starttls-use-gnutls t)
;;
;;(require 'mew-passwd)
;;;; Optional setup (Read Mail menu):
;;(setq read-mail-command 'mew)
;;
;;;; Optional setup (e.g. C-xm for sending a message):
;;(autoload 'mew-user-agent-compose "mew" nil t)
;;(if (boundp 'mail-user-agent)
;;    (setq mail-user-agent 'mew-user-agent))
;;(if (fboundp 'define-mail-user-agent)
;;    (define-mail-user-agent
;;      'mew-user-agent
;;      'mew-user-agent-compose
;;      'mew-draft-send-message
;;      'mew-draft-kill
;;      'mew-send-hook))
;; 
;;(setq mew-ssl-verify-level 0)
;;(setq mew-use-cached-passwd t)
;;
;;;;Use the default UTF-8 to send email
;;(setq mew-charset-m17n "utf-8")
;;(setq mew-internal-utf-8p t)
;;
;;;;TO DO actually, the mew now can not use master-passwd
;;;;(setq mew-use-master-passwd t)
;;;;(setq mew-prog-pgp "gpg2")
;;
;;(require 'mew-cfg)
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flyspell
;; Check your english spell
;; use M-x flyspell-mode  enable it
;; 1.7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(global-set-key (kbd "C-c v") 'flyspell-mode)

(defun my-max-window()
	(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
		'(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
	(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
		'(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
(run-with-idle-timer 1 nil 'my-max-window)


;; TRAMP
;; for remote access file
;; note:
;;      if you want to access local file with root power, using:
;;      C-x C-f /su::/etc/resolv.conf
;; or   C-x C-f /sudo::/etc/resolv.conf
(add-to-list 'load-path 
	(concat relative-dir "/tool/tramp/lisp/"))
(add-to-list 'Info-default-directory-list 
	(concat relative-dir "/tool/tramp/info/"))
(require 'tramp)
(setq tramp-default-user "user"
	    tramp-defalt-host "172.16.11.7")
(add-to-list 'backup-directory-alist
			 (cons "." 
				(concat relative-dir "/EmacsData/auto-save-list/")))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-chunksize 500) ;; just add this in case of hung

