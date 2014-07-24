

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C- 按键
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(global-set-key (kbd "C-a") 'move-beginning-of-line)
(global-set-key (kbd "C-e") 'move-end-of-line)

(global-set-key (kbd "C-p") 'previous-line)
(global-set-key (kbd "C-n") 'next-line)

(global-set-key (kbd "C-b") 'backward-char)
(global-set-key (kbd "C-f") 'forward-char)

(global-set-key (kbd "C-d") 'delete-char)

(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-y") 'yank)

(global-set-key (kbd "C-g") 'keyboard-quit)

(global-set-key (kbd "C-v") 'scroll-up) 
(global-set-key (kbd "M-v") 'scroll-down)

(global-set-key (kbd "C-s") 'isearch-forward)
(global-set-key (kbd "C-r") 'isearch-backward)

(global-set-key (kbd "C-q") 'set-mark-command)

(global-set-key (kbd "C-i") 'yas/expand)

(global-set-key (kbd "C-,") 'ace-jump-mode)
(global-set-key (kbd "C-.") 'ace-jump-mode-pop-mark) ;;就是跳转会使用ace-jump的位置

(global-set-key (kbd "C-o") 'open-line) ;;光标以后的东西产生新的一行，光标还是在上一行

;; C-u  数字操作的前缀

(global-set-key "\C-hk" 'describe-key)
(global-set-key "\C-hf" 'describe-function)
(global-set-key "\C-hv" 'describe-variable)

(global-set-key (kbd "C-j") 'newline-and-indent) ;;回车，自动缩进
(global-set-key (kbd "C-l") 'recenter-top-bottom) ;;光标位置固定，上下滚屏

(global-set-key (kbd "C-z") 'suspend-frame) ;;停止emacs，退回到cml，在cml里面使用fg切换回来

(global-set-key (kbd "C-/") 'undo)


;;(global-set-key (kbd "C-m") 'cscope-select-entry-other-window)
;;(global-set-key (kbd "C-o") 'aaaaa)


;; ctl-t-map  新的ctrl-t的前缀
;;(global-set-key (kbd "C-t") 'aa)


;;;;;;;;;;;;;;;;;;;;;;;;
;; M- 快捷键

(global-set-key (kbd "M-a") 'backward-sentence)
(global-set-key (kbd "M-e") 'forward-sentence)

(global-set-key (kbd "M-f") 'forward-word)
(global-set-key (kbd "M-b") 'backward-word)

(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)

(global-set-key (kbd "M-d") 'kill-word)

;; 单词的大小写转换
(global-set-key (kbd "M-c") 'capitalize-word)
(global-set-key (kbd "M-u") 'upcase-word)
(global-set-key (kbd "M-l") 'downcase-word)

(global-set-key (kbd "M-w") 'kill-ring-save) ;;就是复制啦

(global-set-key (kbd "M-h") 'mark-paragraph)

(global-set-key (kbd "M-k") 'kill-sentence)

(global-set-key (kbd "M-j") 'c-indent-new-comment-line) ;; C语言中，多行注释的扩展，包含 // /* 类型的

(global-set-key (kbd "M-m") 'back-to-indentation) ;;跳回到行首非空白字符

(global-set-key (kbd "M-v") 'scroll-down)  ;;向下卷屏，相反于C-v

(global-set-key (kbd "M-r") 'move-to-window-line-top-bottom) ;;移动光标到屏幕的开头，中间，结尾

(global-set-key (kbd "M-k") 'kill-sentence) ;;删除句子

(global-set-key (kbd "M-t") 'transpose-words) ;; 光标位置的前后单词相互调换

(global-unset-key (kbd "M-o")) ;; set-face
(global-unset-key (kbd "M-i")) ;;
(global-set-key (kbd "M-i") 'semantic-ia-complete-symbol)
(global-set-key (kbd "M-o") 'semantic-ia-fast-jump)

(global-set-key (kbd "M-y") 'yank-pop) ;;默认C-y是粘贴，如果前面一条命令是C-y，
                                       ;;那么M-y慢慢前面替换kill-ring里面的内容

;; M-g 前缀 M-g M-p next-error

;; m-q   m-s

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x 开头的快捷键
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key ctl-x-map "C-b" 'buffer-menu)
(define-key ctl-x-map "C-c" 'save-buffers-kill-terminal)
(define-key ctl-x-map "d"   'list-directory) ;;deprecated
(define-key ctl-x-map "C-d" 'joc-dired-magic-buffer)
(define-key ctl-x-map "C-f" 'find-file)
(define-key ctl-x-map "C-j" 'dired-jump) ;;跳到编辑文件对应的dired目录

(define-key ctl-x-map "C-u" 'upcase-region)
(define-key ctl-x-map "C-l" 'downcase-region)

(define-key ctl-x-map "C-o" 'delete-blank-lines)
(define-key ctl-x-map "C-p" 'mark-page)
(define-key ctl-x-map "C-r" 'find-file-read-only)
(define-key ctl-x-map "C-s" 'save-buffer)
(define-key ctl-x-map "C-t" 'transpose-lines)  ;;将当前行和前面一行进行位置对调
(define-key ctl-x-map "C-v" 'find-alternate-file) ;;发现错打开文件的时候
(define-key ctl-x-map "C-w" 'write-file) ;;可以另存为文件
(define-key ctl-x-map "C-x" 'exchange-point-and-mark)

(define-key ctl-x-map "0" 'delete-window)
(define-key ctl-x-map "1" 'delete-other-windows)
(define-key ctl-x-map "2" 'split-window-vertically)
(define-key ctl-x-map "3" 'split-window-horizontally)

(define-key ctl-x-map "b" 'switch-to-buffer)
(define-key ctl-x-map "m" 'wenshan-edit-current-file-as-root) ;;sudo编辑当前文件

(define-key ctl-x-map "u" 'undo)
(define-key ctl-x-map "z" 'repeat)  ;;重复执行上条命令

(define-key ctl-x-map "k" 'kill-buffer) ;;删除buffer，在minibuffer中提示删除的buffer名字
(define-key ctl-x-map "l" 'goto-line)   ;;Same as M-g M-g
(define-key ctl-x-map "h" 'mark-whole-buffer)
(define-key ctl-x-map "i" 'insert-buffer) ;; 将文件插入到当前buffer中


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-c 前缀

(define-key ctl-c-map "s" 'query-replace)

(define-key ctl-c-map "a" 'ack)
(define-key ctl-c-map "f" 'ack-find-file) ;;在当前路径中，选择目录打开的文件

;;(local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)  ;;Ctrl-return 弹出补全菜单
;;(local-set-key "\C-ci" 'semantic-ia-complete-symbol)         ;;提示可以补全的函数原型
;;(local-set-key "\C-ct" 'semantic-complete-analyze-inline)    ;;minubuffer打印出全面的函数原型
;;(local-set-key "\C-c=" 'semantic-decoration-include-visit)   ;;浏览打开光标所在处的xxx.h头文件
;;(local-set-key "\C-cj" 'semantic-ia-fast-jump)               ;;跳转到定义处
;;(local-set-key "\C-cd" 'semantic-ia-show-doc)                ;;没有的话跳转到定义
;;(local-set-key "\C-cs" 'semantic-ia-show-summary)
;;(local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)  ;;函数原型和函数定义之间的跳转(有时候不管用)

;;(local-set-key "\C-ch" 'eassist-switch-h-cpp)
;;(local-set-key "\C-cl" 'eassist-list-methods)       ;;列出当前文档的函数列表，可以进行快速跳转
;;(local-set-key "\C-c\C-r" 'semantic-symref)         ;;检查当前光标所在位置函数的引用信息
;;(local-set-key "\C-c\C-t" 'semantic-symref-symbol)  ;;提示输入要查找的符号


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc 按键
(global-set-key (kbd "<f2>") 'ansi-term-visit-dwim)
(global-set-key (kbd "<f8>") 'menu-bar-mode)

(global-set-key (kbd "<f9>") 'ecb-hide-ecb-windows)
(global-set-key (kbd "ESC <f9>") 'ecb-show-ecb-windows)
(global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "<f10>") 'gnus)


(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

(global-set-key [C-left] 'tabbar-ruler-tabbar-forward-tab)
(global-set-key [C-right] 'tabbar-ruler-tabbar-backward-tab)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 个人使用的前缀
;; 用户用的C-t前缀按键
;; flyspell拼写检查，采用的huspell引擎
(define-key ctl-t-map "f" 'flyspell-buffer)
(define-key ctl-t-map "v" 'flyspell-mode)


(provide 'global-keyboard-keymap)
