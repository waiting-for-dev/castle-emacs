;; EMACS CONFIG
(global-set-key (kbd "C-c C-SPC") 'eshell)
;; PACKAGES
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

;; Vim major mode
(use-package evil
  :ensure t
  :config
  ;; Enable on start-up
  (evil-mode 1)
  ;; Evil and Proof General compatibility: https://github.com/syl20bnr/spacemacs/issues/8853#issuecomment-302706114
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  )

;; Auto-completion
(use-package company-mode
  :config
  (company-mode)
  :commands (global-company-mode)
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  (eval-after-load 'company
    '(push 'company-robe company-backends)))

;; Auto-close `end` blocs in ruby
(use-package ruby-end
  :ensure t)

;; Code navigation, documentation lookup and completion for Ruby
(use-package robe
  :ensure t
  :commands (robe-mode)
  :init
  (add-hook 'ruby-mode-hook 'robe-mode))

;; Project management
(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  )
(use-package projectile-rails
  :ensure t
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
