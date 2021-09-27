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
;; Display line number in buffers
(global-display-line-numbers-mode)

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
  ("C-h S" . counsel-describe-symbol))

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

;; Use projectile
;; Project integration
(use-package projectile
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (when (file-directory-p "~/Projects/Code")
    (setq projectile-project-search-path '("~/Projects/Code")))
  (setq projectile-switch-project-action #'projectile-dired)
  (setq projectile-completion-system #'ivy))

(use-package magit
  :bind
  ("C-c g s" . magit-status))

;; Use doom-modeline
;; >> Note: it is required to install all-the-icons
;; >> M-x all-the-icons-install-fonts
(use-package doom-modeline
  :init
  (setq doom-modeline-height 15)
  (doom-modeline-mode 1))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ispell-dictionary nil)
 '(package-selected-packages
   '(magit projectile which-key helpful ivy-rich doom-modeline counsel ivy use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
