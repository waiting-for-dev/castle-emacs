;; EMACS CONFIG
;; Launch terminal emulator --
;; https://emacs.stackexchange.com/questions/42513/launch-term-in-command-line-default-directory
(global-set-key (kbd "C-c C-SPC")
		(lambda (local)
		  (interactive "P")
		  (message "local: %S" local)
		  (let ((default-directory (if local
					       default-directory
					     command-line-default-directory)))
		    (term (getenv "SHELL")))))

;; Return to previous buffer
(global-set-key (kbd "C-c b") 'mode-line-other-buffer)

;; When opening a file which is a symlink under VC, open the "real" file
(setq vc-follow-symlinks t)

;; Do not open `GNU Emacs` buffer on startup
(setq inhibit-splash-screen t)

;; Fullscreen startup - https://emacs.stackexchange.com/a/3017
(add-to-list 'initial-frame-alist '(fullscreen . fullboth))

;; Ido mode
(ido-mode 1)
(setq ido-enable-flex-matching t)

;; Highlight matching parenthesis
(show-paren-mode t)

;; Default browser
(setq browse-url-browser-function 'browse-url-chromium)

;; Do not change `default directory` with current buffer
;; (add-hook 'find-file-hook
;; 	  (lambda ()
;; 	    (setq default-directory command-line-default-directory)))

;; Command to open init.el quickly
(defun initel ()
  (interactive)
  (find-file "~/.emacs.d/init.el"))

;;; Do not clutter with backup/autosave files
;;; https://stackoverflow.com/a/2020954/877028
(defvar backup-dir (expand-file-name "~/.emacs.d/backup/"))
(defvar autosave-dir (expand-file-name "~/.emacs.d/autosave/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

;; Do not add new line at the end of the file
(setq mode-require-final-newline nil)

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

;; Ido in vertical mode
(use-package ido-vertical-mode
  :ensure t
  :init
  (ido-vertical-mode 1))

;; Proof general
(use-package proof-general
	     :ensure t
	     :no-require t)

(use-package proof-site
  :mode ("\\.v\\'" . coq-mode))

;; Syntax checking
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)
  :config
  (with-eval-after-load 'intero
    (flycheck-add-next-checker 'intero '(warning . haskell-hlint))))

;; Git frontend
(use-package magit
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status))

;; Vim major mode
(use-package evil
  :ensure t
  :config
  ;; Enable on start-up
  (evil-mode 1)
  ;; Evil and Proof General compatibility: https://github.com/syl20bnr/spacemacs/issues/8853#issuecomment-302706114
  (setq evil-want-abbrev-expand-on-insert-exit nil)
  ;; Disable in the term
  (evil-set-initial-state 'term-mode 'emacs)
  ;; Unbind `M-.` key, used in emacs to jump to definition
  (eval-after-load "evil-maps"
    (define-key evil-normal-state-map "\M-." nil)))

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

;; Elixir mode
(use-package elixir-mode
  :ensure t)

;; Elixir tooling
(use-package alchemist
  :ensure t)

;; Haskell mode
(use-package haskell-mode
  :ensure t
  :config
  (custom-set-variables '(haskell-stylish-on-save t)))

;; Haskell tools
(use-package intero
  :ensure t
  :commands (intero-mode)
  :init
  (add-hook 'haskell-mode-hook 'intero-mode))

;; Haskell code formatter
(use-package hindent
  :ensure t
  :commands (hindent-mode)
  :config
  (setq hindent-reformat-buffer-on-save t)
  :init
  (add-hook 'haskell-mode-hook #'hindent-mode))

;; Coq tools
(use-package company-coq
  :ensure t
  :commands (company-coq-mode)
  :init
  (add-hook 'coq-mode-hook #'company-coq-mode))
  
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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-stylish-on-save t)
 '(package-selected-packages
   (quote
    (proof-general magit use-package alchemist elixir-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
