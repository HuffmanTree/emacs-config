;; Emacs configuration starting

;; Start on *scratch* buffer
(setq inhibit-startup-message t)

;; Disable menu bar
(menu-bar-mode -1)
;; Disable scroll bar
(scroll-bar-mode -1)
;; Disable tool bar
(tool-bar-mode -1)
;; Display column offset in mini-buffer
(column-number-mode)
;; Display line number in all buffers
(global-display-line-numbers-mode)
;; Disable line number in some buffers
(dolist (mode '(term-mode-hook
		shell-mode-hook
		eshell-mode-hook
		treemacs-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(setq default-frame-alist '((font . "DejaVu Sans Mono-8")))

;; Use the wombat theme
(load-theme 'wombat)

;; Show matching pairs of parentheses and other characters
(show-paren-mode)

;; Load package
(require 'package)

;; Initialize package sources
(setq package-archives '(("elpa" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Load use-package
(require 'use-package)

;; Ensure package is present by default
(setq use-package-always-ensure t)

;; Use quelpa-use-package
;; improvment for use-package
(use-package quelpa-use-package)

;; Use auto-package-update
;; Automatically update packages
(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results nil)
  :config
  (auto-package-update-maybe))

;; Use ivy
;; Advanced completion
;; swiper (search): ivy--regex-plus rule
;; else ivy--regex-ignore-order
(use-package ivy
  :init
  (setq ivy-re-builders-alist '((swiper . ivy--regex-plus) (t . ivy--regex-ignore-order)))
  :bind
  ("C-s" . swiper))

;; Use ivy-rich
(use-package ivy-rich
  :init
  (ivy-rich-mode 1))

;; Use counsel
;; Native operations improvements
(use-package counsel
  :bind
  ("M-x" . counsel-M-x)
  ("C-x C-f" . counsel-find-file)
  ("C-x b" . counsel-switch-buffer)
  ("C-h b" . counsel-descbinds)
  ("C-h f" . counsel-describe-function)
  ("C-h v" . counsel-describe-variable) 
  ("C-h S" . counsel-describe-symbol)
  ("C-x p" . counsel-package))

;; Use helpful
;; Enhance *Help* buffer
(use-package helpful
  :init
  (setq counsel-describe-function-function #'helpful-callable)
  (setq counsel-describe-variable-function #'helpful-variable)
  (setq counsel-describe-symbol-function #'helpful-symbol))

;; Use which-key
;; Gives key bindings mappings from prefixes
(use-package which-key
  :init
  (which-key-mode)
  :config
  (setq which-key-idle-delay 1.5))

;; Use all-the-icons
;; Required by
;; - doom-modeline
(use-package all-the-icons)

(defun say-hello ()
   "Says hello."
   (interactive)
   (message "Hello, World!"))

;; Use projectile
;; Project integration
(use-package projectile
  :config
  (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-completion-system #'ivy))

;; Use magit
(use-package magit
  :bind
  ("C-c g s" . magit-status))

;; Use doom-modeline
(use-package doom-modeline
  :after
  (all-the-icons)
  :init
  (setq doom-modeline-height 15)
  (doom-modeline-mode 1))

;; Use org-mode
(use-package org)

;; Use company
;; Enable completion
(use-package company
  :config
  (global-company-mode t))

;; Use company-box
;; Front rendering for company completion
(use-package company-box
  :hook
  (company-mode . company-box-mode)
  :config
  (setq company-box-backends-colors '((company-capf :all "white" :selected (:background "lime" :foreground "black")))))

;; Use flycheck
(use-package flycheck)

;; Use lsp-mode
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :commands
  (lsp lsp-deferred)
  :config
  (lsp-enable-which-key-integration t))

;; Use lsp-ui
(use-package lsp-ui
  :after
  (lsp-mode)
  :config
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-show-code-actions t)
  (setq lsp-ui-doc-enable nil)
  (setq lsp-diagnostics-provider :auto)
  (setq lsp-ui-sideline-show-diagnostics t))

;; Use lsp-treemacs
(use-package lsp-treemacs
  :after
  (lsp-mode)
  :init
  (treemacs-resize-icons 16))

;; Use dap-mode
;; debugging tool for lsp
(use-package dap-mode)

;; Use python-mode
;; Load lsp when mode starts
(use-package python-mode
  :ensure nil
  :mode "\\.py\\'"
  :hook
  (python-mode . lsp-deferred)
  :custom
  (python-shell-intxerpreter "python3")
  (lsp-pyls-plugins-flake8-enabled t))

;; Use js2-mode
;; Load lsp when mode starts
;; Load dap-mode when mode starts
(use-package js2-mode
  :mode "\\.js\\'"
  :hook
  (js2-mode . lsp-deferred)
  :config
  (setq js-indent-level 2)
  (require 'dap-node)
  (dap-node-setup))

;; Use typescript-mode
;; Load lsp when mode starts
;; Load dap-mode when mode starts
(use-package typescript-mode
  :mode "\\.ts\\'"
  :hook
  (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2)
  (require 'dap-node)
  (dap-node-setup))

;; Use vue-mode
;; Load lsp when mode starts
(use-package vue-mode
  :mode "\\.vue\\'"
  :hook
  (vue-mode . lsp-deferred)
  :config
  (setq js-indent-level 2)
  (setq typescript-indent-level 2)
  (setq css-indent-offset 2))

;; Use json-mode
;; Load lsp when mode starts
(use-package json-mode
  :mode "\\.json\\'"
  :hook
  (json-mode . lsp-deferred)
  :config
  (setq js-indent-level 2))

;; Use yaml-mode
;; Load lsp when mode starts
(use-package yaml-mode
  :hook
  (yaml-mode . lsp-deferred)
  :mode "\\.yml")

;; Use dotenv-mode
;; Load lsp when mode starts
(use-package dotenv-mode
  :mode "\\.env")

;; Use dockerfile-mode
;; Load lsp when mode starts
(use-package dockerfile-mode
  :hook
  (dockerfile-mode . lsp-deferred))

;; Use dired
;; ensure: nil, don't install native package
;; -a: display files / folders starting with '.'
;; -h: human readable
;; -g: don't show the user
;; -o: don't show the group
;; --group-directories-first: folders before files
(use-package dired
  :ensure nil
  :commands
  (dired dired-jump)
  :custom
  (dired-listing-switches "-agoh --group-directories-first")
  :bind (:map dired-mode-map
	      ("h" . dired-single-up-directory)
	      ("l" . dired-single-buffer)
	      ("H" . dired-hide-dotfiles-mode)))

;; Use dired-single
;; dired opened in only one single buffer
(use-package dired-single)

;; Use dired-hide-dotfiles
;; toggle hide / display dot files
(use-package dired-hide-dotfiles)

;; Use all-the-icons-dired
;; Icons for dired
(use-package all-the-icons-dired
  :hook
  (dired-mode . all-the-icons-dired-mode))

;; Use prettier-js
;; For
;; - VueJS
;; - Javascript
;; - Typescript
;; - JSON
;; - YAML
(use-package prettier-js
  :init
  (add-hook 'vue-mode-hook 'prettier-js-mode)
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'typescript-mode-hook 'prettier-js-mode)
  (add-hook 'json-mode-hook 'prettier-js-mode)
  (add-hook 'yaml-mode-hook 'prettier-js-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(flycheck auto-package-update auto-update-package quelpa-use-package dap-mode dired-hide-dotfiles all-the-icons-dired dired-single dired lsp-treemacs vue-mode dockerfile-mode js2-mode dotenv-mode yaml-mode prettier-js json-mode typescript-mode lsp-ui lsp-mode company-box company magit projectile which-key helpful ivy-rich doom-modeline counsel ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
