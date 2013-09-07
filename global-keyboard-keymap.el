

;; 用户用的C-t前缀按键
(global-unset-key (kbd "C-t"))
(define-prefix-command 'global-ct-keymap)
(global-set-key (kbd "C-t") 'global-ct-keymap)

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

(global-unset-key (kbd "C-o")) ;;'open-line
(global-set-key (kbd "C-o") 'ace-jump-mode)

(global-set-key "\C-hk" 'describe-key)
(global-set-key "\C-hf" 'describe-function)
(global-set-key "\C-hv" 'describe-variable)

(global-set-key (kbd "C-j") 'newline-and-indent) ;;回车，自动缩进
(global-set-key (kbd "C-l") 'recenter-top-bottom) ;;光标位置固定，上下滚屏

;;(global-set-key (kbd "C-t") 'aa)
;;(global-set-key (kbd "C-m") 'bb)



;;;;;;;;;;;;;;;;;;;;;;;;
;; M- 快捷键

(global-set-key (kbd "M-a") 'backward-sentence)
(global-set-key (kbd "M-e") 'forward-sentence)

(global-set-key (kbd "M-f") 'forward-word)
(global-set-key (kbd "M-b") 'backward-word)

(global-set-key (kbd "M-p") 'forward-paragraph)
(global-set-key (kbd "M-n") 'backward-paragraph)

(global-set-key (kbd "M-c") 'capitalize-word)
(global-set-key (kbd "M-u") 'upcase-word)
(global-set-key (kbd "M-l") 'downcase-word)

(global-set-key (kbd "M-w") 'kill-ring-save)

(global-set-key (kbd "M-h") 'mark-paragraph)

(global-set-key (kbd "M-k") 'kill-sentence)

(global-set-key (kbd "M-m") 'back-to-indentation) ;;跳回到行首非空白字符

(global-set-key (kbd "M-r") 'move-to-window-line-top-bottom) ;;移动光标到屏幕的开头，中间，结尾

(global-set-key (kbd "M-t") 'transpose-words) ;; 

(global-unset-key (kbd "M-o")) ;; set-face
(global-unset-key (kbd "M-i")) ;;
(global-set-key (kbd "M-i") 'semantic-ia-complete-symbol)
(global-set-key (kbd "M-o") 'semantic-ia-fast-jump)

(global-set-key (kbd "M-y") 'yank-pop) ;;默认C-y是粘贴，如果前面一条命令是C-y，
                                       ;;那么M-y慢慢前面替换kill-ring里面的内容



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x 开头的快捷键
(define-key ctl-x-map "C-b" 'buffer-menu)
(define-key ctl-x-map "C-c" 'save-buffers-kill-terminal)
(define-key ctl-x-map "d" 'list-directory) ;;deprecated
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





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Misc 按键
(global-set-key (kbd "<f2>") 'ansi-term-visit-dwim)
(global-set-key (kbd "<f10>") 'ecb-hide-ecb-windows)
(global-set-key (kbd "ESC <f10>") 'ecb-show-ecb-windows)
(global-set-key (kbd "<f11>") 'toggle-fullscreen)
(global-set-key (kbd "<f12>") 'gnus)



(provide 'global-keyboard-keymap)