(setq delete-old-versions -1 )		; delete excess backup versions silently
(setq version-control t )		; use version control
(setq vc-make-backup-files t )		; make backups file even when in version controlled dir
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ; which directory to put backups file
(setq vc-follow-symlinks t )				       ; don't ask for confirmation when opening symlinked file
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ;transform backups file name
(setq inhibit-startup-screen t )	; inhibit useless and old-school startup screen
(setq ring-bell-function 'ignore )	; silent bell when you make a mistake
(setq coding-system-for-read 'utf-8 )	; use utf-8 by default
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)	; sentence SHOULD end with only a point.
(setq default-fill-column 80)		; toggle wrapping text at the 80th character
(setq initial-scratch-message "Welcome in Emacs") ; print a default message in the empty scratch buffer opened at startup


;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
			 ("gnu"   . "http://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-check-syntax-automatically (quote (save idle-change)))
 '(flycheck-idle-change-delay 4)
 '(package-selected-packages
   (quote
    (org-bullets org indent-guide counsel ivy evil-magit magit avy spaceline company flycheck neotree helm-projectile helm-rg general which-key helm evil use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map "jk" 'evil-normal-state)
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
  (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
  (define-key evil-normal-state-map "j" 'evil-next-visual-line)
  (define-key evil-normal-state-map "k" 'evil-previous-visual-line)
  (define-key evil-visual-state-map "j" 'evil-next-visual-line)
  (define-key evil-visual-state-map "k" 'evil-previous-visual-line)
  (define-key evil-normal-state-map (kbd "C-j") 'move-text-down)
  (define-key evil-normal-state-map (kbd "C-k") 'move-text-up)
  (evil-global-set-key 'normal "H" 'evil-first-non-blank)
  (evil-global-set-key 'visual "H" 'evil-first-non-blank)
  (evil-global-set-key 'motion "H" 'evil-first-non-blank)
  (evil-global-set-key 'normal "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'visual "L" (lambda () (interactive) (evil-end-of-line)))
  (evil-global-set-key 'motion "L" (lambda () (interactive) (evil-end-of-line)))
  (define-key evil-motion-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-normal-state-map "gl" 'evil-avy-goto-line)
  (define-key evil-motion-state-map "go" 'evil-avy-goto-char-2)
  (define-key evil-normal-state-map "go" 'evil-avy-goto-char-2)
  )


;; Theme
(use-package doom-themes
  :ensure t
  :config
  (load-theme 'doom-one t))

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
	helm-mode-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match t
	helm-locate-fuzzy-match t
	helm-semantic-fuzzy-match t
	helm-imenu-fuzzy-match t
	helm-completion-in-region-fuzzy-match t
	helm-candidate-number-list 80
	helm-split-window-in-side-p t
	helm-move-to-line-cycle-in-source t
	helm-echo-input-in-header-line t
	helm-autoresize-max-height 0
	helm-autoresize-min-height 20)
  :config
  (helm-mode 1))

;; RipGrep
(use-package helm-rg :ensure t)

;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; Helm Projectile
(use-package helm-projectile
  :ensure t
  :init
  (setq helm-projectile-fuzzy-match t)
  :config
  (helm-projectile-on))

;; All The Icons
(use-package all-the-icons :ensure t)

;; NeoTree
(use-package neotree
  :ensure t
  :init
  (setq neo-theme (if (display-graphic-p) 'icons 'arrow)))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode))

;; Magit
(use-package magit
  :ensure t
  )

(use-package evil-magit
  :ensure t
  )


(use-package avy
    :ensure t
    :commands (avy-goto-word-1)
    )

(add-hook 'python-mode-hook 'hs-minor-mode)

;; Custom keybinding
(use-package general
  :ensure t
  :config
  (general-evil-setup t)
  (general-define-key
    :states '(normal visual insert emacs)
    :prefix "SPC"
    :non-normal-prefix "C-SPC"
    "l" 'avy-goto-line
    "/"   '(helm-projectile-rg :which-key "ripgrep")
    "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
    "SPC" '(helm-M-x :which-key "M-x")

    ;; projectile
    "p"  '(:ignore t :which-key "Projectile")
    "pf"  '(helm-projectile-find-file :which-key "find files")
    "pp"  '(helm-projectile-switch-project :which-key "switch project")
    "pb"  '(helm-projectile-switch-to-buffer :which-key "switch buffer")
    "pr"  '(helm-show-kill-ring :which-key "show kill ring")

    ;; Buffers
    "b"  '(:ignore t :which-key "Buffer")
    "bb"  '(helm-mini :which-key "buffers list")
    "bd"  'kill-buffer-and-window
    ;; org
    "o"  '(:ignore t :which-key "Org")
    "oa"  'org-archive-subtree
    "oc"  'org-capture
    ;; Window
    "w"  '(:ignore t :which-key "Window")
    "wl"  '(windmove-right :which-key "move right")
    "wh"  '(windmove-left :which-key "move left")
    "wk"  '(windmove-up :which-key "move up")
    "wj"  '(windmove-down :which-key "move bottom")
    "w/"  '(split-window-right :which-key "split right")
    "w-"  '(split-window-below :which-key "split bottom")
    "wx"  '(delete-window :which-key "delete window")
    "qz"  '(delete-frame :which-key "delete frame")
    "qq"  '(kill-emacs :which-key "quit")
    ;; file
    "f"  '(:ignore t :which-key "File")
    "ft"  '(neotree-toggle :which-key "toggle neotree")
    "ff"  'counsel-find-file
    ;; error
    "e"  '(:ignore t :which-key "Error")
    "eb"  'flycheck-buffer
    "el"  'flycheck-list-errors
    "en"  'flycheck-next-error
    "ep"  'flycheck-previous-error
    ;; Others
    "at"  '(ansi-term :which-key "open terminal")
    "g"  '(:ignore t :which-key "Git")
    "gs" '(magit-status :which-key "git status")
))

;; Flycheck
(use-package flycheck
  :ensure t
  :init
  (global-flycheck-mode)

;;  (flycheck-check-syntax-automatically (quote (save idle-change mode- enabled)))
;;  (flycheck-idle-change-delay 4) ;; Set delay based
  )

;; Company mode
(use-package company
:ensure t
:init
(setq company-minimum-prefix-length 3)
(setq company-auto-complete nil)
(setq company-idle-delay 0)
(setq company-require-match 'never)
(setq company-frontends
  '(company-pseudo-tooltip-unless-just-one-frontend
    company-preview-frontend
    company-echo-metadata-frontend))
(setq tab-always-indent 'complete)
(defvar completion-at-point-functions-saved nil)
:config
(global-company-mode 1)
(define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
(define-key company-active-map (kbd "S-TAB") 'company-select-previous)
(define-key company-active-map (kbd "<backtab>") 'company-select-previous)
(define-key company-mode-map [remap indent-for-tab-command] 'company-indent-for-tab-command)
(defun company-indent-for-tab-command (&optional arg)
  (interactive "P")
  (let ((completion-at-point-functions-saved completion-at-point-functions)
	(completion-at-point-functions '(company-complete-common-wrapper)))
	(indent-for-tab-command arg)))

(defun company-complete-common-wrapper ()
	(let ((completion-at-point-functions completion-at-point-functions-saved))
	(company-complete-common))))

;; Powerline
(use-package spaceline
  :ensure t
  :init
  (setq powerline-default-separator 'slant)
  :config
  (spaceline-emacs-theme)
  (spaceline-toggle-minor-modes-off)
  (spaceline-toggle-buffer-size-off)
  (spaceline-toggle-evil-state-on))



(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;; indent-guide
(use-package indent-guide
  :ensure t
  :init
  (indent-guide-global-mode)
  (setq indent-guide-delay 0.1))


(add-hook 'before-save-hook 'whitespace-cleanup)

;; org mode
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-hook 'org-mode-hook 'visual-line-mode)

(setq org-capture-templates
    '(("n" "Note" entry (file+headline "~/Dropbox/orgzly/notes.org" "NOTES")
	"* %?\nEntered on %U\n  %i\n  %a")
	("t" "Task" entry (file+headline "~/Dropbox/orgzly/TODO.org" "Tasks")
	"* TODO %?\n  %u\n  %a")
	("j" "Journal" entry (file+olp+datetree "~/Dropbox/orgzly/journal.org")
	"* %?\nEntered on %U\n  %i\n  %a")))
