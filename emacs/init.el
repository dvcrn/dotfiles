(setq user-full-name "David Mohl")
(setq user-mail-address "emacs@davemail.io")

(setq exec-path (append exec-path '("/usr/local/bin")))
(require 'cl)

;; set up melpa
(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl
    (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives (cons "gnu" (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
;; (package-refresh-contents)

;; done with melpa

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode 1))

(use-package swiper :ensure t)
(use-package counsel :ensure t)
(use-package counsel-projectile :ensure t :config (setq projectile-project-search-path '("~/src/" "~/go/src/github.com/kouzoh/" "~/go/src/github.com/dvcrn/")))
(use-package projectile :ensure t :config (projectile-mode 1))
(use-package ivy
  :ensure t
  :config
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  (setq ivy-display-style 'fancy)
  (ivy-mode 1))

(use-package magit
  :ensure t
  :config
  (with-eval-after-load 'evil-maps
    (define-key evil-normal-state-map " gs" 'magit-status)))

(use-package diff-hl
  :ensure t
  :config
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (global-diff-hl-mode))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :custom
  (evil-collection-company-use-tng nil)
  :config
  (evil-collection-init))

(use-package company
  :ensure t
  :config
  (global-company-mode)
  (define-key evil-insert-state-map (kbd "C-n") 'company-select-next-if-tooltip-visible-or-complete-selection)
  (define-key company-active-map (kbd "C-n") 'company-select-next-if-tooltip-visible-or-complete-selection)
  (define-key company-active-map (kbd "C-p") 'company-select-previous-or-abort))

(use-package neotree
  :ensure t
  :config
  (define-key evil-normal-state-map " pt" 'neotree-toggle)
  (define-key evil-normal-state-map " pF" 'neotree-find)
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
  (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
  (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
  (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
  (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
  (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle))

(use-package exec-path-from-shell :ensure t)

(use-package seoul256-theme
    :ensure t
    :config (load-theme 'seoul256 t))

(use-package smart-mode-line :ensure t)

(use-package nlinum-relative
  :ensure t
  :config
  (setq nlinum-relative-redisplay-delay 0)
  (setq nlinum-relative-offset 0)
  ;; something else you want
  (global-nlinum-mode)
  (nlinum-relative-setup-evil)
  (add-hook 'prog-mode-hook 'nlinum-relative-mode))

;; syntax
(use-package flycheck
  :ensure t
  :config (global-flycheck-mode))

;; snippets
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))

(use-package yasnippet-snippets :ensure t)

;; yaml
(use-package yaml-mode :ensure t)
(use-package flycheck-yamllint
  :ensure t
  :defer t
  :init
  (progn
    (eval-after-load 'flycheck
      '(add-hook 'flycheck-mode-hook 'flycheck-yamllint-setup))))

;; language server
(use-package lsp-mode
  :ensure t
  :commands lsp
  :hook
  (go-mode . lsp)
  (js-mode . lsp)
  (elixir-mode . lsp)
  :config
  (defvar lsp-language-id-configuration
     '(
      (python-mode . "python")
      (javascript-mode . "javascript")
      (js-mode . "javascript"))))

;; optional - provides fancier overlays
(use-package lsp-ui
  :ensure t
  :config
 ;;'(lsp-ui-doc-enable nil)
 '(lsp-ui-sideline-enable nil))

;; if you use company-mode for completion (otherwise, complete-at-point works out of the box):
(use-package company-lsp
  :ensure t
  :commands company-lsp)

(use-package lsp-treemacs :ensure t :commands lsp-treemacs-errors-list)
(use-package dap-mode :ensure t)

;; languages
(use-package go-mode :ensure t
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (evil-define-key 'normal go-mode-map "gd" (lambda () (interactive) (evil--jumps-push) (godef-jump))))

(use-package flycheck-golangci-lint
  :ensure t
  :hook (go-mode . flycheck-golangci-lint-setup)
  :config
  ;; skips 'vendor' directories and sets GO15VENDOREXPERIMENT=1
  (setq flycheck-gometalinter-vendor t)
  ;; only show errors
  (setq flycheck-gometalinter-errors-only t)
  ;; only run fast linters
  (setq flycheck-gometalinter-fast t)
  ;; use in tests files
  (setq flycheck-gometalinter-test t)
  ;; disable linters
  ;; (setq flycheck-gometalinter-disable-linters '("gotype" "gocyclo"))
  ;; Only enable selected linters
  ;; (setq flycheck-gometalinter-disable-all t)
  ;; (setq flycheck-gometalinter-enable-linters '("golint"))
  ;; Set different deadline (default: 5s)
  (setq flycheck-gometalinter-deadline "10s"))

(use-package company-go
  :ensure t
  :config
  (add-hook 'go-mode-hook (lambda ()
			    (set (make-local-variable 'company-backends) '(company-go))
			    (company-mode))))

(use-package applescript-mode :ensure t)

;; Elixir
(use-package elixir-mode :ensure t)
(use-package alchemist :ensure t :hook (elixir-mode . alchemist-mode))
(use-package flycheck-mix :ensure t)

;; Lisps
(use-package lispy :ensure t
  :config
  (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1))))

(use-package lispyville :ensure t
  :config
  (add-hook 'lispy-mode-hook #'lispyville-mode)
  (setq lispyville-key-theme '(operators c-w slurp/barf-cp prettify additional additional-insert))
  (lispyville-set-key-theme))

(use-package highlight-parentheses :ensure t :config (global-highlight-parentheses-mode))


;; take gopath from users shell settings
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH")
  (exec-path-from-shell-copy-env "PATH"))

;; Options
(server-start) 				;; start emacs server
(setq inhibit-startup-screen t) 	;; hide startup screen
(scroll-bar-mode -1) 			;; Don't care about scrollbar
(tool-bar-mode -1) 			;; Don't care about toolbar
(menu-bar-mode 1)            	        ;; Not setting this makes the window uncontrollable with magnet
(show-paren-mode 1)	                ;; Highlight closing paren
(electric-pair-mode) 			;; automatically insert closing brackets
(global-hl-line-mode 1) 		;; highlight current line
(set-frame-font "Operator Mono 15" nil t)


;;Exit insert mode by pressing j and then j quickly
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "fd" 'evil-normal-state)

;; switch buffer
(define-key evil-normal-state-map  " bb" 'ivy-switch-buffer)
(define-key evil-normal-state-map  (kbd "C-b") 'ivy-switch-buffer)

;; project stuff
(define-key evil-normal-state-map  " pf" 'counsel-projectile-find-file)
(define-key evil-normal-state-map  " p/" 'counsel-projectile-ag)
(define-key evil-normal-state-map  (kbd "C-p") 'counsel-projectile-find-file)
(define-key evil-normal-state-map  " pp" 'counsel-projectile-switch-project)

(define-key evil-normal-state-map  " ff" 'counsel-projectile)

;; window
(define-key evil-normal-state-map  " wv" 'split-window-horizontally)
(define-key evil-normal-state-map  " wh" 'split-window-vertically)

(define-key evil-normal-state-map  "]q" 'flycheck-next-error)
(define-key evil-normal-state-map  "[q" 'flycheck-previous-error)

(define-key evil-normal-state-map  "]c" 'diff-hl-next-hunk)
(define-key evil-normal-state-map  "[c" 'diff-hl-previous-hunk)

;; indent when hitting REt
(define-key evil-insert-state-map (kbd "RET") 'newline-and-indent)


;; switch to last tab
(defun switch-to-last-buffer ()
  "Switch to last active buffer."
  (interactive)
  (switch-to-buffer nil))

(define-key evil-normal-state-map  (kbd "SPC TAB") 'switch-to-last-buffer)
;; (define-key dired-mode-map (kbd "SPC TAB") 'switch-to-last-buffer)

;; close ivy with esc
(define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
(define-key swiper-map [escape] 'minibuffer-keyboard-quit)

;; delete last word with C-w in ivy-mode
(define-key ivy-minibuffer-map  (kbd "C-w") 'evil-delete-backward-word)

;; Keybonds
(global-set-key [(hyper a)] 'mark-whole-buffer)
(global-set-key [(hyper v)] 'yank)
(global-set-key [(hyper c)] 'kill-ring-save)
(global-set-key [(hyper s)] 'save-buffer)
(global-set-key [(hyper l)] 'goto-line)
(global-set-key [(hyper w)]
                (lambda () (interactive) (delete-window)))
(global-set-key [(hyper z)] 'undo)


(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)

;; Improve scrolling
(setq scroll-step            1
      scroll-conservatively  10000)

;;---------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-company-use-tng nil)
 '(lispyville-motions-put-into-special t)
 '(lsp-ui-sideline-enable nil)
 '(package-selected-packages
   (quote
    (flycheck-yamllint yaml-mode kubernetes magit evil-collection flycheck-golangci-lint lispy lispyville highlight-parentheses evil-cleverparens dap-mode lsp-treemacs smartparens flycheck-mix nlinum-relative yasnippet-snippets use-package-chords smart-mode-line seoul256-theme neotree lsp-ui flycheck-gometalinter exec-path-from-shell evil-surround counsel-projectile company-lsp company-go))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:foreground "#D9D9D9" :background "#4B4B4B")))))
