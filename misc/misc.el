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
;;   misc.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Theme
(add-to-list 'custom-theme-load-path
	     	(concat relative-dir "/misc/theme-solarized/"))
(load-theme 'solarized-light t);
(require 'dired-x)
;; Use this, we can quickly jump to the current buffer's dired
(global-set-key "\C-x\C-j" 'dired-jump)
(define-key global-map (kbd "C-x 4 C-j") 'dired-jump-other-window)

(setq dired-guess-shell-alist-user
      (list
       (list "\\.chm$" "xchm")
       )
)

;; dired-single
(require 'dired-single)
(defun  my-dired-init ()
 "Bunch of stuff to run for dired, either immediately or when it's loaded."
;; <add other stuff here>
        (define-key dired-mode-map [return] 'joc-dired-single-buffer)
        (define-key dired-mode-map [mouse-1] 'joc-dired-single-buffer-mouse)
        (define-key dired-mode-map "^"
              (function
               (lambda nil (interactive) (joc-dired-single-buffer "..")))))

      ;; if dired's already loaded, then the keymap will be bound
      (if (boundp 'dired-mode-map)
              ;; we're good to go; just add our bindings
              (my-dired-init)
        ;; it's not loaded yet, so add our bindings to the load-hook
        (add-hook 'dired-load-hook 'my-dired-init))



(add-hook 'dired-load-hook
          (lambda ()
            (define-key dired-mode-map (kbd "RET") 'joc-dired-single-buffer)
            (define-key dired-mode-map (kbd "<mouse-1>") 'joc-dired-single-buffer-mouse)
            (define-key dired-mode-map (kbd "^")
              (lambda ()
                (interactive)
                (joc-dired-single-buffer "..")))
            (setq joc-dired-use-magic-buffer t)
            (setq joc-dired-magic-buffer-name "*dired*")))
(global-set-key (kbd "C-x C-d")
                'joc-dired-magic-buffer)

;; author: pluskid
;; 调用 stardict 的命令行接口来查辞典
;; 如果选中了 region 就查询 region 的内容，
;; 否则就查询当前光标所在的词
(require 'showtip)

;;(global-set-key (kbd "C-c e") 'kid-star-dict)
(defun kid-star-dict ()
  (interactive)
  (let ((begin (point-min))
        (end (point-max)))
    (if mark-active
        (setq begin (region-beginning)
              end (region-end))
      (save-excursion
        (backward-word)
        (mark-word)
        (setq begin (region-beginning)
              end (region-end))))
    ;; 有时候 stardict 会很慢，所以在回显区显示一点东西
    ;; 以免觉得 Emacs 在干什么其他奇怪的事情。
    (message "searching for %s ..." (buffer-substring begin end))
    (tooltip-show
     (shell-command-to-string
      (concat "sdcv -n "
              (buffer-substring begin end))))))


;; ace-jump-mode
;; jump to the word start with xxx
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c f") 'ace-jump-mode)
;; enable a more powerful jump back function from ace jump mode 
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-c g") 'ace-jump-mode-pop-mark)



;; session 
;; save the corresponding things
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq session-save-file 
	(concat relative-dir "/EmacsData/session" ))



;; help to search and deal with recent file
;; already included in the emacs
(require 'recentf)
(recentf-mode 1)



;; browse-kill-ring
;; this is very helpful, can browse your kill ring, and hit return can paste they here
(require 'browse-kill-ring)
(global-set-key (kbd "C-c k") 'browse-kill-ring) 

;; buffer-menu+
;; already handled with >24.1 compatible
(load-file "~/Study/GitHub/dot.emacs.d.git/misc/buff-menu.el")
(require 'buff-menu+)
(global-set-key (kbd "C-x C-b") 'buffer-menu)   ;; seems much better


;; for ido enhance
;; ido InteractivelyDoThings
;; It can dynamiclly do the completion in the minibuffer for you without TAB
;; C-x C-f  // C-x b   ==> C-f C-b exchange
;; C-s -- next   C-r previous
;; (require 'ido)
;; (ido-mode t)
(require 'ido)
(require 'ido-ubiquitous)
(require 'flx-ido)

(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-create-new-buffer 'always
      ido-use-filename-at-point 'guess
      ido-max-prospects 10
      ido-save-directory-list-file (expand-file-name "ido.hist" relative-data-dir)
      ido-default-file-method 'selected-window
      ido-auto-merge-work-directories-length -1)
(ido-mode +1)
(ido-ubiquitous-mode +1)

;;; smarter fuzzy matching for ido
(flx-ido-mode +1)
;; disable ido faces to see flx highlights
(setq ido-use-faces nil)

;;; smex, remember recently and most frequently used commands
(require 'smex)
(setq smex-save-file (expand-file-name ".smex-items" relative-data-dir))
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)


;; Auto close and reuse termianl --> ansi-term
(require 'terminal)


;;  Emacs code patch, for windows applications
(require 'emacs-code-patch)

;; use apsell as ispell backend  
(setq-default ispell-program-name "aspell")  
;; use American English as ispell default dictionary  
(ispell-change-dictionary "american" t)  


;; change windows through M-1, M-2 ,M-3...
(require 'window-numbering)

;; auto fillup parans
(require 'smartparens)
(smartparens-global-mode t)

;; tarbar & ruler
(setq tabbar-ruler-global-tabbar t) ; If you want tabbar
(setq tabbar-ruler-global-ruler t) ; if you want a global ruler
(setq tabbar-ruler-popup-scrollbar t) ; If you want to only show the
(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

(require 'tabbar-ruler)

(provide 'misc)
