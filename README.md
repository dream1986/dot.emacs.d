emacs-profile
=============
nicol's emacs costomize

Maybe it is not that valuable to you, just for my self backup!

If you are interested in it, you can use it freely:
git clone https://github.com/taozhijiang/dot.emacs.d

then modifiy your ~/.emacs & .gnus.el(if you use gnus read newsgroup)
~/.emacs
==============
(defconst relative-dir "~/GitHub/dot.emacs.d.git/")
(add-to-list 'load-path relative-dir)
(require 'init-emacs)

~/.gnus.el
==============
(defconst relative-dir "~/GitHub/dot.emacs.d.git/")
(add-to-list 'load-path 
	(concat relative-dir "/gnus/"))

(require 'init-gnus)

Note: you should change your relative-dir to your dot.emacs.d correspondingly.

This customization may contain some of my personal information, please
do not do evil with it! :-)

Merged to virtualbox from vmware
		2013.10.07
