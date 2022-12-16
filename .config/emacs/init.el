;;emacs auto-generated settings moved to separate file
(setq custom-file "~/dotfiles/.config/emacs/custom.el")
(load custom-file)

;;appearance
(set-face-attribute 'default nil :family "SourceCodePro" :height 180)
(load-theme 'deeper-blue)

(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(setq visible-bell t)
(set-fringe-mode 10)
(menu-bar-mode -1)

;;packages
;;(require 'package)
(add-to-list 'package-archives '(("melpa" . "https://melpa.org/packages/")
                                ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package ivy
  :diminish
  :config
  (ivy-mode 1))

(use-package all-the-icons)
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))
