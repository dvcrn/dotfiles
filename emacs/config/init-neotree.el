(require-package 'neotree)
(require 'neotree)

(evil-leader/set-key "b" 'neotree-toggle)
(evil-leader/set-key "f" 'neotree-find)

(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "i") 'neotree-enter-horizontal-split)
            (define-key evil-normal-state-local-map (kbd "I") 'neotree-enter-vertical-split)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))

; Allow opening of files in new splits
(define-key neotree-mode-map (kbd "i") #'neotree-enter-horizontal-split)
(define-key neotree-mode-map (kbd "I") #'neotree-enter-vertical-split)

(provide 'init-neotree)
