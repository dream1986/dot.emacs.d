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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Latest org
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path
			 (concat relative-dir "/tool/org-8.1/lisp"))
(add-to-list 'load-path 
			 (concat relative-dir "/tool/org-8.1/contrib/lisp/") t)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

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
	    tramp-defalt-host "172.16.17.131")
(add-to-list 'backup-directory-alist
			 (cons "." 
				(concat relative-dir "/EmacsData/auto-save-list/")))
(setq tramp-backup-directory-alist backup-directory-alist)
(setq tramp-chunksize 500) ;; just add this in case of hung


;;;
(add-to-list 'load-path
			 (concat relative-dir "/tool/org2blog/"))
;; Preload
(add-to-list 'load-path
			 (concat relative-dir "/tool/org2blog/metaweblog/"))
(require 'metaweblog)
(require 'xml-rpc)
(require 'org2blog-autoloads)

(provide 'tool)

