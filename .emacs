;; -*- lexical-binding: t; -*- ;;
;;; Commentary:
;;; Code:
(setq load-prefer-newer t)
(setq use-package-always-defer nil)

;;; #undo-tree
(use-package undo-tree
  :config
  (global-undo-tree-mode 1))

;;; #direnv  
(use-package direnv
  :config
  (direnv-mode))
  :demand t

(use-package emacs
  :init
  :config
  (setq-default
    global-display-line-numbers-mode 1
    display-line-numbers-type 'relative
    enable-recursive-minibuffers t
    context-menu-mode t
    use-short-answers t
    create-lockfiles nil
    tab-always-indent 'complete
    echo-keystrokes 0.1
    mode-line-compact t
    global-prettify-symbols-mode nil
    font-lock-maximum-decoration t))
  
(use-package project)
    
;;; MELPA packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq custom-file "~/.emacs.custom.el")
(setq ring-bell-function 'ignore)
(setq global-visual-line-mode '1)
(require 'tree-sitter)
(require 'tree-sitter-langs) 
(global-tree-sitter-mode)

;;; #dired
(use-package dired
  :config
  (setq insert-directory-program "ls" dired-use-ls-dired t) 
  (setq dired-listing-switches "-al --group-directories-first")
  :hook
  ((dired-mode . dired-hide-details-mode)))  

;;; #flymake
(use-package flymake
  :ensure t
  :pin gnu
  :config
  (setq flymake-diagnostic-format-alist
        '((t . (origin code message)))))
(setq flymake-mode-line-format '(" 🧸 "))

;;; *eglot
(use-package eglot
  :config
  (setq eglot-ignored-server-capabilities
    '(:inlayHintProvider)))

;;; cmode
;; (require 'simpc-mode)
;; (add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
         ("C-c C-e" . markdown-do)))

;; NIX (NIXOS)
(use-package nix-mode
:mode ("\\.nix\\'" "\\.nix.in\\'"))
(use-package nix-drv-mode
  :ensure nix-mode
  :mode "\\.drv\\'")
(use-package nix-shell
   :ensure nix-mode
  :commands (nix-shell-unpack nix-shell-configure nix-shell-build))
 (use-package nix-repl
   :ensure nix-mode
   :commands (nix-repl))

;;; #org
(use-package org
  :config
  ;; Org babel/source blocks
  (setq org-src-fontify-natively t
        org-src-window-setup 'current-window
        org-src-strip-leading-and-trailing-blank-lines t
        org-src-preserve-indentation t
        org-src-tab-acts-natively t
        org-adapt-indentation nil))
  
(setq org-hide-emphasis-markers 't)

(add-hook 'org-mode-hook 'org-indent-mode)
(add-hook 'org-mode-hook 'visual-line-mode)    
   
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(corfu--bar ((t (:inherit corfu-default))) t)
 '(corfu-border ((t (:background "light steel blue"))))
 '(corfu-default ((t (:inherit default :slant italic :height 1.0))))
 '(org-default ((t (:inherit default))))
 '(org-document-title ((t (:inherit bold :height 1.5 :slant italic))))
 '(org-level-1 ((t (:height 1.4 :slant italic :overline t))))
 '(org-level-2 ((t (:height 1.1 :slant italic :overline t))))
 '(org-verbatim ((t (:inherit (shadow fixed-pitch)))))
 '(tuareg-font-double-semicolon-face ((t (:inherit default)))))

;;; #go
(add-hook 'go-mode-hook '(lambda () (setq tab-width 4)))
(add-hook 'go-mode-hook 'eglot-ensure)  

(setq org-hide-leading-stars 'nil)  
(setq org-hide-emphasis-markers 'nil)
  
;;; #rust
(require 'rust-mode)
(add-hook 'rust-mode-hook
          (lambda () (setq indent-tabs-mode nil)))
(add-hook 'rust-mode-hook 'eglot-ensure)
(add-hook 'rust-mode-hook
          (lambda () (setq eglot-inlay-hints-mode nil)))
(setq rust-format-on-save t)

;;; #ocaml
(require 'tuareg)
(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit\\'" . tuareg-mode)))

(add-hook 'tuareg-mode-hook 'eglot-ensure)

(add-hook 'tuareg-mode-hook (lambda ()
  (define-key tuareg-mode-map (kbd "C-M-<tab>") #'ocamlformat)
  (add-hook 'before-save-hook #'ocamlformat-before-save)))

(add-hook 'tuareg-mode-hook
          (lambda () (setq tuareg-mode-name "🐫")))

(add-hook 'tuareg-mode-hook
  ( lambda ))

(use-package ocamlformat		
  :custom (ocamlformat-enable 'enable-outside-detected-project)
  :hook (before-save . ocamlformat-before-save))
    
;;; #basics
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(show-paren-mode 1)
(electric-pair-mode 't)
(global-font-lock-mode 1)
(setq undo-limit 500)
(toggle-truncate-lines 0)
(setq truncate-partial-width-windows nil)
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(setq-default tab-width 2)
(setq column-number-mode 1)
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'insert-tab)
(setq make-backup-files nil)  

(keymap-global-set "M-\\" 'other-window)
(keymap-global-set "M-#" 'delete-window)
(keymap-global-set "M-u" 'compile)
(keymap-global-set "M-o" 'recompile)
  
;;; #corfu  
(use-package corfu
  :custom
  (corfu--bar ((t (:inherit corfu-default))) t)
  (corfu-border ((t (:background "light steel blue"))))
  (corfu-default ((t (:inherit default :slant italic :height 1.0))))
  (setq corfu-bar-width 0)
  (corfu-popupinfo-delay '(0.5 . 0.5))
  (corfu-auto t)
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-preview-current t)    ;; Disable current candidate preview
  (corfu-preselect 'prompt)      ;; Preselect the prompt
  (corfu-on-exact-match 'insert) ;; Configure handling of exact matches
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

;; Enable Vertico.
(use-package vertico
  :custom
  (vertico-scroll-margin 0) ;; Different scroll margin
  (vertico-count 8) ;; Show more candidates
  (vertico-resize nil) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))
  (savehist-mode 1)

;;; #elfeed
(global-set-key (kbd "C-x w") 'elfeed)
  (setq elfeed-feeds
      '("https://seated.ro/rss.xml"
        "https://andersmurphy.com/feed.xml"
        "https://zwit.link/atom.xml"
        "https://ryan.freumh.org/atom.xml"
        "https://sin-ack.github.io/index.xml"
        "https://pthorpe92.dev/archive/"
        "https://graffioh.com/blog"
        "https://borretti.me/feed.xml"
        "https://andreyor.st/feed.xml"
        "https://tarides.com/feed.xml"
        "https://doisinkidney.com/rss.xml"
        "https://www.scd31.com/posts.rss"
        "https://blog.phronemophobic.com/rss.xml"))

;;; #meow  
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("o" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("D" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))
(require 'meow)
(meow-setup)
(meow-global-mode 0)
(meow-setup-indicator)
(setq meow-cursor-type-insert '(box . 5))
(setq meow-expand-hint-counts '((word . 0)
                                 line . 0))  
;;; #avy
(global-set-key (kbd "C-'") 'avy-goto-char-timer)
(setq avy-timeout-seconds '0.5)

;;; #aesthetics
(load-theme 'modus-operandi-tritanopia t)
(setq modus-operandi-tritanopia-palette-overrides modus-themes-preset-overrides-faint)
(blink-cursor-mode 0)
(tooltip-mode -1)
(global-hl-line-mode 1)

(set-face-attribute 'default nil :font "Monaco"
                    :height 200 :weight 'book)
(set-face-attribute 'fixed-pitch nil :family "Monaco")
  
(set-face-attribute 'variable-pitch nil
                      :family "Georgia"
                      :height 1.0 :weight 'medium)

(add-to-list 'default-frame-alist
             '(font . "Monaco")
             '(font . "Georgia"))

(set-fontset-font "fontset-default" 'unicode "Apple Color Emoji" nil 'prepend)  
  
  
(provide '.emacs)
;;; .emacs ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(magit-git-executable
  "/nix/store/x34bh6s6ighg7lb74nkjbx3nx52zj0j9-git-2.51.2/bin/git")
 '(mode-line-compact t)
 '(org-hide-emphasis-markers t t)
 '(package-selected-packages
  '(corfu direnv elfeed flymake go-mode magit markdown-mode meow
          nix-mode ocamlformat tree-sitter tree-sitter-langs tuareg
          vertico white-theme)))
