(global-unset-key (kbd "C-t"))
(define-prefix-command 'global-ct-keymap)
(global-set-key (kbd "C-t") 'global-ct-keymap)

(provide 'global-ct-keymap)