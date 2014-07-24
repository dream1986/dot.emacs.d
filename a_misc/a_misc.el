
;; 插入，竖线条    改写/只读，方块
;; box  hellow(中空)  bar  hbar
(require 'cursor-chg)            ; Load this library
(change-cursor-mode 1)           ; On for overwrite/read-only/input mode
(toggle-cursor-type-when-idle 1) ; On when idle

(setq curchg-idle-cursor-type 'hellow);
(setq curchg-overwrite/read-only-cursor-type 'box);


(require 'hl-line+) ; Load this file (it will load `hl-line.el')
(toggle-hl-line-when-idle 1) ; Highlight only when idle
(setq hl-line-idle-interval 2)

(setq c-default-style "linux"
      c-basic-offset 4)


(require 'redo+)
(global-unset-key (kbd "C-\\"))
(global-set-key (kbd "C-\\") 'redo) 

;; Ctrl-TAB 在各个Tabs之间切换
;; (global-set-key [(control tab)] 'bury-buffer)

(require 'ebs)
(ebs-initialize)
(global-set-key [(control tab)] 'ebs-switch-buffer)

;; 让脚本在保存的时候，自动添加可执行权限
 (add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(provide 'a_misc)
