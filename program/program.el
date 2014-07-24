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

;;;;;;;;;;;;;;;;;
;;  header2
(autoload 'auto-update-file-header "header2")
(add-hook 'write-file-hooks 'auto-update-file-header)
(autoload 'auto-make-header "header2")
(add-hook 'c-mode-common-hook   'auto-make-header)
(add-hook 'c++-mode-common-hook   'auto-make-header)


;;develop special key define
;;(defun key (desc)
;;  (or (and window-system (read-kbd-macro desc))
;;	  (or (cdr (assoc desc real-keyboard-keys))
;;		  (read-key-macro desc))))

;;auto-complete
(add-to-list 'load-path 
	(concat relative-dir "/program/auto-complete-1.3.1/"))

(set-default 'ac-sources
               '(ac-source-semantic
                 ac-source-yasnippet
                 ac-source-abbrev
                 ac-source-words-in-buffer
                 ac-source-words-in-all-buffer
                 ac-source-imenu
                 ac-source-files-in-current-dir
                 ac-source-filename))

(require 'auto-complete-config)
(ac-config-default)

(add-to-list 'ac-dictionary-directories 
	(concat relative-dir "/program/auto-complete-1.3.1/ac-dict"))
(setq ac-comphist-file
	(concat relative-dir "/EmacsData/ac-comphist.dat"))

;;For multi-line comment, all begin with /*
(setq comment-multi-line t)

;;compile command
(setq compile-command "make -f Makefile")
;;Allow for multi-window gdb debug
(setq gdb-many-windows t)

;; C language develop
(add-hook 'c-mode-hook
		  '(lambda ()
			 (c-set-style "stroustrup")
			 (c-toggle-auto-state)
			 (c-toggle-hungry-state)
			 (local-set-key [(f5)] 'compile)
			 (local-set-key [(f6)] 'gdb)))

;; C++ language develop
(add-hook 'c++-mode-hook
		  '(lambda ()
			 (c-set-style "stroustrup")
			 (c-toggle-auto-state)
			 (c-toggle-hungry-state)
			 (local-set-key [(f5)] 'compile)
			 (local-set-key [(f6)] 'gdb)))


;;; 
;; cedet

(require 'cedet-cfg)

;; flymake
;; Used for the language syntax check
(require 'flymake-settings)
;; Key bounding
(defvar flymake-mode-map (make-sparse-keymap))
(define-key flymake-mode-map (kbd "C-c C-n") 'flymake-goto-next-error-disp)
(define-key flymake-mode-map (kbd "C-c C-p") 'flymake-goto-prev-error-disp)
(define-key flymake-mode-map (kbd "C-c M-w")
  'flymake-display-err-menu-for-current-line)
	(or (assoc 'flymake-mode minor-mode-map-alist)
    		(setq minor-mode-map-alist
          		(cons (cons 'flymake-mode flymake-mode-map)
               			minor-mode-map-alist)))


;; This for the include headers
;; 安装 abbrev
(mapc
 (lambda (mode)
   (define-abbrev-table mode '(
                               ("inc" "" skeleton-include 1)
                               )))
 '(c-mode-abbrev-table c++-mode-abbrev-table))
 
;; 输入 inc , 可以自动提示输入文件名称,可以自动补全.
(define-skeleton skeleton-include
  "generate include<>" ""
  > "#include <"
  (completing-read "Include File:"
                   (mapcar #'(lambda (f) (list f ))
                           (apply 'append
                                  (mapcar
                                   #'(lambda (dir)
                                       (directory-files dir))
                                   (list "/usr/include"
                                         "/usr/local/include"
					 "/usr/include/bits"
					 "/usr/include/gnu"
					 "/usr/local/include"
					 )))))
  ">")

(defvar wcy-c/c++-hightligh-included-files-key-map nil)
(if wcy-c/c++-hightligh-included-files-key-map
    nil
  (setq wcy-c/c++-hightligh-included-files-key-map (make-sparse-keymap))
  (define-key wcy-c/c++-hightligh-included-files-key-map (kbd "<RET>") 'find-file-at-point))
 
(defun wcy-c/c++-hightligh-included-files ()
  (interactive)
  (when (or (eq major-mode 'c-mode)
            (eq major-mode 'c++-mode))
    (save-excursion
      (goto-char (point-min))
      ;; remove all overlay first
      (mapc (lambda (ov) (if (overlay-get ov 'wcy-c/c++-hightligh-included-files)
                             (delete-overlay ov)))
            (overlays-in (point-min) (point-max)))
      (while (re-search-forward "^#include[ \t]+[\"<]\\(.*\\)[\">]" nil t nil)
        (let* ((begin  (match-beginning 1))
               (end (match-end 1))
               (ov (make-overlay begin end)))
          (overlay-put ov 'wcy-c/c++-hightligh-included-files t)
          (overlay-put ov 'keymap wcy-c/c++-hightligh-included-files-key-map)
          (overlay-put ov 'face 'underline))))))
;; 这不是一个好办法，也可以把它加载到 c-mode-hook or c++-mode-hook 中。
(setq wcy-c/c++-hightligh-included-files-timer (run-with-idle-timer 4 t 'wcy-c/c++-hightligh-included-files))



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ecb  (Emacs Code Browser)
;;

(add-to-list 'load-path 
	(concat relative-dir "/program/ecb-2.40"))
(require 'ecb)
(require 'ecb-autoloads)

;;;
;;(ecb-layout-define "left-symboldef-lite" left nil
;;  (ecb-set-sources-buffer)
;;  (ecb-split-ver 0.2)
;;  (ecb-set-methods-buffer)
;;  (ecb-split-ver 0.5)
;;  (ecb-set-symboldef-buffer)
;;  (select-window (next-window)))

(ecb-layout-define "my-cscope-layout" left nil
                   (ecb-set-history-buffer)
                   (ecb-split-ver 0.25 t)
                   (other-window 1)
                   (ecb-set-methods-buffer)
                   (ecb-split-ver 0.5 t)
                   (other-window 1)
                   (ecb-set-cscope-buffer))

(defecb-window-dedicator ecb-set-cscope-buffer " *ECB cscope-buf*"
                         (switch-to-buffer "*cscope*"))

(setq ecb-layout-name "my-cscope-layout")
;;(setq ecb-layout-name "left-symboldef-lite")

;; Disable buckets so that history buffer can display more entries
(setq ecb-history-make-buckets 'never)

;;(setq ecb-layout-name "left-symboldef")

(setq stack-trace-on-error nil)

(setq ecb-auto-activate t
	  ecb-tip-of-the-day nil)

;; ecb shortcut
(global-set-key [M-left]  'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up]    'windmove-up)
(global-set-key [M-down]  'windmove-down)

;; show & hide ecb multi-windows
(global-set-key (kbd "<f9>") 'ecb-hide-ecb-windows)
(global-set-key (kbd "ESC <f9>") 'ecb-show-ecb-windows)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cscope
;; (require 'xcscope)
;;      C-c s s         Find symbol.
;;      C-c s d         Find global definition.
;;      C-c s g         Find global definition (alternate binding).
;;      C-c s G         Find global definition without prompting.
;;      C-c s c         Find functions calling a function.
;;      C-c s C         Find called functions (list functions called
;;                      from a function).
;;      C-c s t         Find text string.
;;      C-c s e         Find egrep pattern.
;;      C-c s f         Find a file.
;;      C-c s i         Find files #including a file.


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; git-emacs
;; The front interface of the git for emacs editor
(add-to-list 'load-path
			 (concat relative-dir "/program/git-emacs/" ))
(require 'git-emacs)


;;;;;;;;;;;;;;;;;;;;;;;;;
;; doxymacs
(add-to-list 'load-path
			 (concat relative-dir "/program/doxymacs/" ))
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
 (defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)

;;
;; - Default key bindings are:
;; - C-c d ? will look up documentation for the symbol under the point.
;;  - C-c d r will rescan your Doxygen tags file.
;;  - C-c d f will insert a Doxygen comment for the next function.
;;  - C-c d i will insert a Doxygen comment for the current file.
;;  - C-c d ; will insert a Doxygen comment for the current member.
;;  - C-c d m will insert a blank multi-line Doxygen comment.
;;  - C-c d s will insert a blank single-line Doxygen comment.
;;  - C-c d @ will insert grouping comments around the current region.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; yasippet
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;The yasippet code auto-complete specification
;;You can define yourself complete template for shortcut
(add-to-list 'load-path 
	(concat relative-dir "/program/yasnippet-0.6.1c"))
(require 'yasnippet)
(yas/initialize)
(yas/load-directory 
	(concat relative-dir "/program/yasnippet-0.6.1c/snippets"))
(yas/global-mode)
(global-set-key (kbd "C-c ; u") 'yas/expand)


(provide 'program)
;; The end of the program


