
(defconst relative-dir "~/GitHub/dot.emacs.d/")
(add-to-list 'load-path 
        (concat relative-dir "/gnus/"))

(defconst gnus-relative-dir relative-dir)

(require 'init-gnus)
