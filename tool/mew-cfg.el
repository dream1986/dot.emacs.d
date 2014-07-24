
(autoload 'mew "mew" nil t)
(autoload 'mew-send "mew" nil t)

;; Optional setup (Read Mail menu):
(setq read-mail-command 'mew)

;; Optional setup (e.g. C-xm for sending a message):
(autoload 'mew-user-agent-compose "mew" nil t)
(if (boundp 'mail-user-agent)
    (setq mail-user-agent 'mew-user-agent))
(if (fboundp 'define-mail-user-agent)
    (define-mail-user-agent
      'mew-user-agent
      'mew-user-agent-compose
      'mew-draft-send-message
      'mew-draft-kill
      'mew-send-hook))

;; use emacs-w3m in Mew
(require 'mew-w3m)
(setq mew-prog-html '(mew-mime-text/html-w3m nil nil))
(setq mew-mime-multipart-alternative-list '("Text/Html" "Text/Plan" ".*"))

;; using fetch for PGP instead of wget
(setq mew-prog-pgpkey "fetch")
(setq mew-prog-pgpkey-arg '("-q" "-o" "-"))
(provide 'mew-cfg)
