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

;;;;;;
;; Org Mode
;;
(add-to-list 'load-path
	(concat relative-dir "/tool/org-8.2.7b/lisp"))
(add-to-list 'load-path
	(concat relative-dir "/tool/org-8.2.7b/contrib/lisp") t)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(setq org-src-fontify-natively t)   
(setq org-startup-indented t)


;; 强制的
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(add-hook 'org-mode-hook 'turn-on-font-lock)
(transient-mark-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; flyspell
;; Check your english spell
;; use M-x flyspell-mode  enable it
;; 1.7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(setq-default ispell-program-name "hunspell")
(define-key ctl-t-map "f" 'flyspell-buffer)
(define-key ctl-t-map "v" 'flyspell-mode)

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
	    tramp-defalt-host "172.16.17.131")
(add-to-list 'backup-directory-alist
			 (cons "." 
				(concat relative-dir "/EmacsData/auto-save-list/")))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-chunksize 500) ;; just add this in case of hung


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ack-and-a-half
(require 'ack-and-a-half)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(define-key ctl-c-map "a" 'ack)
(define-key ctl-c-map "f" 'ack-find-file) ;;在当前路径中，选择目录打开的文件


;; org secret
;; org-mode 設定
(require 'epa-file)
(epa-file-enable)  ;;this will auto encrypt *.gpg file

(setq epa-file-select-keys 0)
(setq epa-file-cache-passphrase-for-symmetric-encryption t)

(require 'org-crypt)
;; 當被加密的部份要存入硬碟時，自動加密回去
;; M-x org-decrypt-entry 
(org-crypt-use-before-save-magic)
;; 設定要加密的 tag 標籤為 secret
(setq org-crypt-tag-matcher "secret")   ;;Using C-c C-c to add tag
;; 避免 secret 這個 tag 被子項目繼承 造成重複加密
(setq org-tags-exclude-from-inheritance (quote ("secret")))
;; 可以設定任何 ID 或是設成 nil 來使用對稱式加密 (symmetric encryption)
(setq org-crypt-key nil)



;; use C-= to expand the region to select, intelligent
(add-to-list 'load-path 
	(concat relative-dir "/tool/expand-region/"))
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C--") 'er/contract-region)

(provide 'tool)

