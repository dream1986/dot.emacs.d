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
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories 
	(concat relative-dir "/program/auto-complete-1.3.1/ac-dict"))
(ac-config-default)
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
			 (local-set-key [(f7)] 'compile)
			 (local-set-key [(f8)] 'gdb)))

;; C++ language develop
(add-hook 'c++-mode-hook
		  '(lambda ()
			 (c-set-style "stroustrup")
			 (c-toggle-auto-state)
			 (c-toggle-hungry-state)
			 (local-set-key [(f7)] 'compile)
			 (local-set-key [(f8)] 'gdb)))


;;;;;;;;;;;;;;;;;;;;;;;
;;emacs cedet
;;
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another 
;; package (Gnus, auth-source, ...).
;;(load-file "~/.emacs.d/program/cedet-1.1/common/cedet.el")

;; remove the build-in cedet
(setq load-path (remove "/usr/local/share/emacs/23.4/lisp/cedet" load-path))
(add-to-list 'load-path
			 (concat relative-dir "/program/cedet-1.1/common"))
(load-file 
	(concat relative-dir "/program/cedet-1.1/common/cedet.el"))
(setq semanticdb-default-save-directory 
	(concat relative-dir "/EmacsData/semanticdb/"))
;; just for try
(setq auto-save-hook nil)

;; Enable EDE (Project Management) features
;;(global-ede-mode 1)

;;;;;;;;;;;;;;;;;;;;;;;
;; semantic mode select
(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(semantic-load-enable-guady-code-helpers)
(semantic-load-enable-excessive-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

;; I use this to accelarate cedet with cscope
(semanticdb-enable-cscope-databases)
;;
(require 'semantic-ia)
;; Include system inc files
(require 'semantic-gcc)

;;(require 'eieio-opt)

;; add for the usr & sys inc dir
(defconst cedet-user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public" "."
        "../.." "../../include" "../../inc" "../../common" "../../public"))
(setq cedet-sys-include-dirs (list
							  "/usr/include"
							  "/usr/include/bits"
							  "/usr/include/glib-2.0"
							  "/usr/include/gnu"
							  "/usr/local/include/c++/4.4.4/"
							  "/usr/local/include"
							  "~/GitHub/kernel-src.git/linux-2.6.32-358.18.1.el6/include/")
)
(semantic-add-system-include  "~/GitHub/kernel-src.git/linux-2.6.32-358.18.1.el6/include/" 'c-mode)

(let ((include-dirs cedet-user-include-dirs))
  (setq include-dirs (append include-dirs cedet-sys-include-dirs))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(defun my-cedet-hook()
;;  (local-set-key [(control return)] 'semantic-ia-complete-symbol)
;;  (local-set-key "\C-c?" 'semantic-ia-complete-symbol-menu)
  (local-set-key (kbd "M-n") 'semantic-ia-complete-symbol-menu)

;;  (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;  (local-set-key (kbd "M-/") 'semantic-complete-analyze-inline)

;;  (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;  (local-set-key "\C-cd" 'semantic-ia-fast-jump)
;;  (local-set-key "\C-cr" 'semantic-symref-symbol)
;;  (local-set-key "\C-cR" 'semantic-symref)
  ;;; c/c++ setting
;;  (local-set-key "." 'semantic-complete-self-insert)
;;  (local-set-key ">" 'semantic-complete-self-insert)
)

(add-hook 'c-mode-common-hook 'my-cedet-hook)
(add-hook 'c++-mode-common-hook 'my-cedet-hook)


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
					 "/usr/include/glib-2.0"
					 "/usr/include/gnu"
					 "/usr/include/gtk-2.0"
					 "/usr/include/gtk-2.0/gdk-pixbuf"
					 "/usr/include/gtk-2.0/gtk"
					 "/usr/local/include"
					 "/usr/include/c++/4.4.4/"
					 "/usr/local/include/c++/4.4.4/"
	       			  "~/GitHub/kernel-src.git/linux-2.6.32-358.18.1.el6/include/"
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
;; ecb
;;
;;
(add-to-list 'load-path 
	(concat relative-dir "/program/ecb-2.40"))
(require 'ecb)
(require 'ecb-autoloads)
;;(setq ecb-layout-name "left-symboldef-lite")

(setq stack-trace-on-error nil)

(setq ecb-auto-activate t
	  ecb-tip-of-the-day nil)

;; ecb shortcut
(global-set-key (kbd "ESC <left>") 'windmove-left)
(global-set-key (kbd "ESC <right>") 'windmove-right)
(global-set-key (kbd "ESC <up>") 'windmove-up)
(global-set-key (kbd "ESC <down>") 'windmove-down)

;; show & hide ecb multi-windows
(global-set-key (kbd "<f10>") 'ecb-hide-ecb-windows)
(global-set-key (kbd "ESC <f10>") 'ecb-show-ecb-windows)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cscope
(require 'xcscope)

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

;;The yasippet code auto-complete specification
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


