;;;;;;;;;;;;;;;;;;;;;;;
;;emacs cedet
;;
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another 
;; package (Gnus, auth-source, ...).
;;(load-file "~/.emacs.d/program/cedet-1.1/common/cedet.el")

(setq cedet-root-path (file-name-as-directory (expand-file-name "/program/cedet-1.1" relative-dir)))
(add-to-list 'load-path (concat cedet-root-path "contrib"))

;; remove the build-in cedet
(setq load-path (remove "/usr/local/share/emacs/24.3/lisp/cedet" load-path))
(add-to-list 'load-path
			 (concat relative-dir "/program/cedet-1.1/common"))
(load-file 
	(concat relative-dir "/program/cedet-1.1/common/cedet.el"))
(setq semanticdb-default-save-directory 
	(concat relative-dir "/EmacsData/semanticdb/"))
(add-to-list 'load-path (concat cedet-root-path "contrib"))
;; just for try
(setq auto-save-hook nil)

;; Enable EDE (Project Management) features
;;(global-ede-mode 1)

;; Activate semantic
(require 'semantic-decorate-include)
(require 'semantic-gcc)
(require 'semantic-ia)

;; gnu global support
(require 'semanticdb)
(require 'semanticdb-global)
;; if you want to enable support for gnu global
(when (cedet-gnu-global-version-check t)
    (semanticdb-enable-gnu-global-databases 'c-mode)
      (semanticdb-enable-gnu-global-databases 'c++-mode))

;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;;(when (cedet-ectag-version-check)
;;    (semantic-load-enable-primary-exuberent-ctags-support))

(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'c++-mode)

(require 'eassist)
(require 'semantic-lex-spp)

(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
 
(custom-set-variables
    '(semantic-idle-scheduler-idle-time 3)
    '(semantic-self-insert-show-completion-function
       (lambda nil (semantic-ia-complete-symbol-menu (point))))
    '(global-semantic-tag-folding-mode t nil (semantic-util-modes)))

;; load contrib library
(require 'eassist)

(add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;;(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
(add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
 
;; depress messages
(setq semantic-idle-scheduler-idle-time 10)
(setq semantic-idle-scheduler-no-working-message nil)
(setq semantic-idle-scheduler-working-in-modeline-flag nil)
(setq semantic-idle-scheduler-verbose-flag nil)

;; customisation of modes
(defun alexott/cedet-hook ()
    ;;Ctrl-回车，菜单列表显示可以补全的信息
    ;;这里的补全采用的全是
    (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)  ;;Ctrl-return 弹出补全菜单
    (local-set-key "\C-ci" 'semantic-ia-complete-symbol)         ;;提示可以补全的函数原型
    (local-set-key "\C-ct" 'semantic-complete-analyze-inline)    ;;minubuffer打印出全面的函数原型
    (local-set-key "\C-c=" 'semantic-decoration-include-visit)   ;;浏览打开光标所在处的xxx.h头文件
    (local-set-key "\C-cj" 'semantic-ia-fast-jump)               ;;跳转到定义处
    (local-set-key "\C-cd" 'semantic-ia-show-doc)                ;;没有的话跳转到定义
    (local-set-key "\C-cs" 'semantic-ia-show-summary)
    (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)  ;;函数原型和函数定义之间的跳转(有时候不管用)
    (add-to-list 'ac-sources 'ac-source-semantic)
)

(add-hook 'c-mode-common-hook 'alexott/cedet-hook)
(add-hook 'c++-mode-common-hook 'alexott/cedet-hook)
(add-hook 'lisp-mode-hook 'alexott/cedet-hook)
(add-hook 'scheme-mode-hook 'alexott/cedet-hook)
(add-hook 'emacs-lisp-mode-hook 'alexott/cedet-hook)
 
(defun alexott/c-mode-cedet-hook ()
    (local-set-key "\C-ch" 'eassist-switch-h-cpp)
    (local-set-key "\C-cl" 'eassist-list-methods)       ;;列出当前文档的函数列表，可以进行快速跳转
    (local-set-key "\C-c\C-r" 'semantic-symref)         ;;检查当前光标所在位置函数的引用信息
    (local-set-key "\C-c\C-t" 'semantic-symref-symbol)  ;;提示输入要查找的符号
)
(add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)

;; hooks, specific for semantic
(defun alexott/semantic-hook ()
    ;;在菜单栏添加一个TAGS标签菜单
    (imenu-add-to-menubar "TAGS")
)
(add-hook 'semantic-init-hooks 'alexott/semantic-hook)
 
 
;; SRecode
(global-srecode-minor-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;
;; semantic mode select
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-guady-code-helpers)  
(semantic-load-enable-excessive-code-helpers)
;;(semantic-load-enable-semantic-debugging-helpers)  ;;semantic本身调试帮助
(global-semantic-stickyfunc-mode -1)    ;;消除第一行的函数原型，干扰tabbar-ruler的工作

;; add for the usr & sys inc dir
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "."
        "../.." "../../include" "../../inc" "../../common" "../../public"))
(setq cedet-sys-include-dirs (list
							  "/usr/include"
							  "/usr/include/bits"
							  "/usr/include/gnu"
							  "/usr/local/include")
)
(semantic-add-system-include  "~/GitHub/kernel-src.git/linux-2.6.32-358.18.1.el6/include/" 'c-mode)

(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))



;; Global
;; Enable helm-gtags-mode
(require 'helm-gtags)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

;; customize
(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))

;; key bindings
(eval-after-load "helm-gtags"
  '(progn
     (define-key helm-gtags-mode-map (kbd "\C-tt") 'helm-gtags-find-tag)
     (define-key helm-gtags-mode-map (kbd "\C-tr") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "\C-ts") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "\C-te") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "\C-tp") 'helm-gtags-previous-history)
     (define-key helm-gtags-mode-map (kbd "\C-tn") 'helm-gtags-next-history)
     (define-key helm-gtags-mode-map (kbd "\C-tq") 'helm-gtags-pop-stack)))

(provide 'cedet-cfg)
