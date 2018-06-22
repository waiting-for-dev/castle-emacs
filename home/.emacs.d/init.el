;; Add melpa as repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Auto-install `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Initialize `use-package`
(eval-when-compile
  (require 'use-package))

;; Let `use-package` auto-install any missing package
(setq use-package-always-ensure t)

;; Vim major mode
(use-package evil
  :config
  ;; Enable on start-up
  (evil-mode 1)
  ;; Evil and Proof General compatibility: https://github.com/syl20bnr/spacemacs/issues/8853#issuecomment-302706114
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  )

;; Auto-close `end` blocs in ruby
(use-package ruby-end)

;; Project management
(use-package projectile
  :config
  (projectile-mode)
  )
(use-package projectile-rails
  :config
  (projectile-rails-global-mode)
  )

;; Open .v files with Proof General's Coq mode
(load "~/.emacs.d/lisp/PG/generic/proof-site")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package alchemist elixir-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
