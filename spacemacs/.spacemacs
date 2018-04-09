;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(osx
     (auto-completion :variables
                      auto-completion-enable-sort-by-usage t
                      auto-completion-enable-snippets-in-popup t
                      auto-completion-return-key-behavior 'complete
                      auto-completion-tab-key-behavior 'complete)
     better-defaults

     ;; Languages
     emacs-lisp
     clojure
     javascript
     html

     erlang
     elixir

     (go :variables
         go-use-gometalinter t
         gofmt-command "goimports")

     ;; Apps
     ;; chrome

     ;; Version control
     git
     github
     version-control

     ;; vim
     evil-snipe

     ;; etc
     shell
     ;; erc
     ;; jabber
     emoji
     colors

     markdown
     (org :variables
          org-enable-github-support t)

     spell-checking
     syntax-checking
     version-control

     themes-megapack
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
   dotspacemacs-themes '(spacemacs-dark
                         zenburn
                         misterioso
                         monokai)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("Operator Mono"
                               :size 16
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
   dotspacemacs-mode-line-theme 'spacemacs
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all
   ;; dotspacemacs-persistent-server t

   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   dotspacemacs-default-package-repository nil)

  (set-face-attribute 'font-lock-comment-delimiter-face nil :slant 'italic)
  (set-face-attribute 'font-lock-comment-face nil :slant 'italic)
  (set-face-attribute 'font-lock-doc-face nil :slant 'italic))


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


(defun figwheel-repl ()
  (interactive)
  (save-some-buffers)
  (with-current-buffer (cider-current-repl-buffer)
    (goto-char (point-max))
    (insert "(require 'figwheel-sidecar.repl-api)
             (cljs-repl)")
    (cider-repl-return)))


(defun dotspacemacs/user-init ()
    (setq evil-escape-delay 0.2))

(defun dotspacemacs/user-config ()
;; (indent-guide-global-mode)
  (global-linum-mode t)
  (linum-relative-global-mode t)
  (global-company-mode)

  ;; trigger auto-complete vim style
  (global-set-key (kbd "C-n") 'company-dabbrev)

  ;; project
  (global-set-key (kbd "C-p") 'helm-projectile-find-file)

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

  ;; different seperator for powerline
  (setq powerline-default-separator 'alternate)
  )


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (flycheck-gometalinter zonokai-theme zenburn-theme zen-and-art-theme yapfify xterm-color ws-butler winum white-sand-theme which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill underwater-theme ujelly-theme twilight-theme twilight-bright-theme twilight-anti-bright-theme toxi-theme toc-org tide typescript-mode tao-theme tangotango-theme tango-plus-theme tango-2-theme tagedit symon swift-mode sunny-day-theme sublime-themes subatomic256-theme subatomic-theme string-inflection spaceline powerline spacegray-theme soothe-theme solarized-theme soft-stone-theme soft-morning-theme soft-charcoal-theme smyx-theme smeargle slim-mode slack circe oauth2 websocket shell-pop seti-theme scss-mode sayid sass-mode salt-mode mmm-jinja2 yaml-mode mmm-mode rvm ruby-tools ruby-test-mode ruby-refactor rubocop rspec-mode robe reverse-theme reveal-in-osx-finder restart-emacs rebecca-theme realgud test-simple loc-changes load-relative rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters railscasts-theme pyvenv pytest pyenv-mode py-isort purple-haze-theme puppet-mode pug-mode professional-theme popwin pony-mode planet-theme pip-requirements phoenix-dark-pink-theme phoenix-dark-mono-theme persp-mode pcre2el pbcopy password-generator paradox ox-gfm osx-trash osx-dictionary orgit organic-green-theme org-projectile org-category-capture org-present org-pomodoro org-download org-bullets open-junk-file omtose-phellack-theme oldlace-theme occidental-theme obsidian-theme noctilux-theme neotree naquadah-theme mwim mustang-theme multi-term move-text monokai-theme monochrome-theme molokai-theme moe-theme minitest minimal-theme material-theme majapahit-theme magit-gitflow magit-gh-pulls madhat2r-theme macrostep lush-theme lorem-ipsum livid-mode skewer-mode live-py-mode linum-relative link-hint light-soap-theme less-css-mode launchctl json-mode json-snatcher json-reformat js2-refactor js2-mode js-doc jbeans-theme jazz-theme jabber fsm ir-black-theme inkpot-theme info+ indent-guide impatient-mode simple-httpd hy-mode hungry-delete htmlize hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt heroku-theme hemisu-theme help-fns+ helm-themes helm-swoop helm-pydoc helm-purpose window-purpose imenu-list helm-projectile helm-mode-manager helm-make projectile helm-gitignore request helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag hc-zenburn-theme haml-mode gruvbox-theme gruber-darker-theme grandshell-theme gotham-theme google-translate golden-ratio godoctor go-rename go-guru go-eldoc gnuplot gmail-message-mode ham-mode markdown-mode html-to-markdown gitignore-mode github-search github-clone gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe+ git-gutter-fringe fringe-helper git-gutter+ git-gutter gist gh marshal logito pcache gandalf-theme fuzzy flyspell-correct-helm flyspell-correct flymd flycheck-pos-tip pos-tip flycheck-mix flycheck-credo flycheck flx-ido flx flatui-theme flatland-theme fill-column-indicator farmhouse-theme fancy-battery eyebrowse expand-region exotica-theme exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-snipe evil-search-highlight-persist org-plus-contrib evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit magit magit-popup git-commit with-editor evil-lisp-state smartparens evil-lion evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree espresso-theme eshell-z eshell-prompt-extras esh-help erlang erc-yt erc-view-log erc-terminal-notifier erc-social-graph erc-image erc-hl-nicks emojify ht emoji-cheat-sheet-plus emmet-mode elisp-slime-nav editorconfig edit-server dumb-jump dracula-theme django-theme disaster diminish diff-hl darktooth-theme autothemer darkokai-theme darkmine-theme darkburn-theme dakrone-theme cython-mode cyberpunk-theme company-web web-completion-data company-tern dash-functional tern company-statistics company-go go-mode company-emoji company-c-headers company-anaconda column-enforce-mode color-theme-sanityinc-tomorrow color-theme-sanityinc-solarized color-identifiers-mode coffee-mode cmake-mode cmake-ide levenshtein clues-theme clojure-snippets clj-refactor hydra inflections edn multiple-cursors paredit peg clean-aindent-mode clang-format cider-eval-sexp-fu eval-sexp-fu highlight cider seq spinner queue clojure-mode chruby cherry-blossom-theme busybee-theme bundler inf-ruby bubbleberry-theme browse-at-remote birds-of-paradise-plus-theme bind-map bind-key badwolf-theme auto-yasnippet yasnippet auto-highlight-symbol auto-dictionary auto-compile packed apropospriate-theme anti-zenburn-theme anaconda-mode pythonic f ample-zen-theme ample-theme alert log4e gntp alect-themes alchemist s company dash elixir-mode pkg-info epl aggressive-indent afternoon-theme adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core async ac-ispell auto-complete popup))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
