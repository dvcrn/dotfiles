;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     osx
     (auto-completion :variables
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete)
     better-defaults

     ;; Languages
     emacs-lisp
     clojure
     (c-c++ :variables c-c++-enable-clang-support t)
     javascript
     html
     typescript
     erlang
     elixir
     salt
     puppet
     python
     django
     ruby
     swift
     go

     ;; Apps
     chrome

     ;; Version control
     git
     github
     version-control

     ;; vim
     ;; vim-powerline
     evil-snipe

     ;; etc
     shell
     erc
     jabber
     emoji
     colors
     ;; (wakatime :variables
     ;;           wakatime-api-key "*****"
     ;;           wakatime-cli-path "/usr/local/bin/wakatime"
     ;;           wakatime-python-bin "/usr/local/bin/python")

     ;; frameworks
     react

     ;; markdown
     (org :variables
          org-enable-github-support t)
     spell-checking
     syntax-checking
     version-control

     themes-megapack
     slack
     )

   dotspacemacs-additional-packages '()
   dotspacemacs-excluded-packages '(auto-complete)
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-editing-style 'hybrid
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner '999
   dotspacemacs-startup-lists '(recents projects)
   dotspacemacs-themes '(
                         spacemacs-dark
                         zenburn
                         misterioso
                         monokai)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Hack"
                               :size 15
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-command-key ":"
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header t
   dotspacemacs-helm-position 'bottom
   dotspacemacs-enable-paste-micro-state nil
   dotspacemacs-which-key-delay 0
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server t
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil))


(defun setup-indent (n)
  ;; web development
  (setq coffee-tab-width n) ; coffeescript
  (setq javascript-indent-level n) ; javascript-mode
  (setq js-indent-level n) ; js-mode
  (setq js2-basic-offset n) ; js2-mode
  (setq web-mode-markup-indent-offset n) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset n) ; web-mode, css in html file
  (setq web-mode-code-indent-offset n) ; web-mode, js code in html file
  (setq web-mode-attr-indent-offset n) ; web-mode, js code in html file
  (setq css-indent-offset n)) ; css-mode


(defun tab-style ()
  (interactive)
  (message "Tab indendation style")
  (setq indent_with_tabs t)
  (setq-default indent-tabs-mode t
                default-tab-width 1)
  (setup-indent 1))


(defun space-style ()
  (interactive)
  (message "Space indendation style")
  (setq indent_with_tabs nil)
  (setq-default indent-tabs-mode nil
                default-tab-width 1)
  (setup-indent 2)
  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil))))


(defun erc-gitter-connect ()
  (interactive)
  ;; clean up old buffers if they exist
  (dolist (buf '("irc.gitter.im:6667" "#syl20bnr/spacemacs"))
    (when (get-buffer buf) (kill-buffer buf)))

  (erc-ssl :server "irc.gitter.im"
           :port 6667
           :nick "dvcrn"
           :password "*****"))

(defun figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (figwheel-sidecar.repl-api/cljs-repl)")
    (cider-repl-return)))

; (defun ambly-repl ()
; 		(interactive)
; 		(with-current-buffer (cider-current-repl-buffer)
; 				(goto-char (point-max))
; 				(insert "
; (require
;   '[cljs.repl :as repl]
;   '[cemerick.piggieback]
;   '[ambly.core :as ambly])
;
; (cemerick.piggieback/cljs-repl
; 	(ambly/repl-env :choose-first-discovered true))")
; (cider-repl-return)


(defun dotspacemacs/user-init ()
    (setq evil-escape-delay 0.2))

(defun dotspacemacs/user-config ()
;; (indent-guide-global-mode)
  (global-linum-mode t)
  (linum-relative-global-mode t)
  (global-company-mode)

  ;; trigger auto-complete vim style
  (global-set-key (kbd "C-n") 'company-dabbrev)

  (space-style)

  ;; Get rid off odd pasting behavior
  (fset 'evil-visual-update-x-selection 'ignore)

  ;; get rid of symbolic link question
  (setq vc-follow-symlinks t)

  ;; Always launch magit in fullscreen
  (setq-default git-magit-status-fullscreen t)

  ;; rainbow mode
  (rainbow-mode)

  ;; Make clojure prettier
  (setq clojure-enable-fancify-symbols t)

  ;; always use react mode with js files
  (add-to-list 'auto-mode-alist '("\\.js\\'" . react-mode))

  ;; different seperator for powerline
  (setq powerline-default-separator 'alternate)

  ;; ruby
  (setq flycheck-disable-checker '(ruby-rubylint))
  )


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
