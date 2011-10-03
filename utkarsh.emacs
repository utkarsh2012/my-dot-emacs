;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

;;    ___ _ __ ___   __ _  ___ ___
;;   / _ \ '_ ` _ \ / _` |/ __/ __|
;;  |  __/ | | | | | (_| | (__\__ \
;; (_)___|_| |_| |_|\__,_|\___|___/
;;
(display-time)
(global-set-key "\C-l" 'goto-line)
(set (make-local-variable 'fill-column) 130)
(set-fringe-style -1)
(tooltip-mode -1)

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)
(global-hl-line-mode 1)
(setq standard-indent 2)
(setq scroll-step 1)
(mouse-wheel-mode t)

;;Enable tab
(global-set-key (kbd "TAB") 'self-insert-command);

;;Deft in the scratch
(setq initial-major-mode 'deft)

(require 'remember)
(setq inhibit-splash-screen t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'load-path "/Users/zengr/dev/emacs/deft")
(require 'deft)
(setq deft-extension "txt")
(setq deft-directory "~/Dropbox/notes")
(setq deft-text-mode 'markdown-mode)

(add-to-list 'load-path "~/dev/emacs/emacs-for-python") ;; tell where to load the various files
(require 'epy-setup) ;; It will setup other loads, it is required!
;(require 'epy-python) ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing) ;; For configurations related to editing [optional]
;(require 'epy-bindings) ;; For my suggested keybindings [optional]

;No backup file (~)
(setq make-backup-files nil)
;; Show line and column number
(line-number-mode 1)
(column-number-mode 1)

(add-to-list 'load-path "~/dev/emacs")
; For Solarized theme
;;(add-to-list 'load-path "~/dev/emacs/emacs-color-theme-solarized")
;;(require 'color-theme-solarized)
;;(require 'color-theme-tomorrow)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/dev/emacs/ac-dict")
(ac-config-default)

(global-set-key "\C-m" 'newline-and-indent)

;auto-indent-start for paste
(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
	   (and (not current-prefix-arg)
		(member major-mode '(emacs-lisp-mode lisp-mode
						     clojure-mode    scheme-mode
						     haskell-mode    ruby-mode
						     rspec-mode      python-mode
						     c-mode          c++-mode
						     objc-mode       latex-mode
						     plain-tex-mode))
		(let ((mark-even-if-inactive transient-mark-mode))
		  (indent-region (region-beginning) (region-end) nil))))))
;auto-indent-end

;; Prevent accidentally killing emacs.
(global-set-key [(control x) (control c)]
		'(lambda ()
		   (interactive)
		   (if (y-or-n-p-with-timeout "Do you really want to exit Emacs ? " 4 nil)
		       (save-buffers-kill-emacs))))

; allows syntax highlighting to work
(global-font-lock-mode 1)

;; Load CEDET.
;; This is required by ECB which will be loaded later.
;; See cedet/common/cedet.info for configuration details.
(load-file "~/dev/emacs/cedet-1.0/common/cedet.el")

;; Enable EDE (Project Management) features
;(global-ede-mode 1)

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

(global-srecode-minor-mode 1)            ; Enable template insertion menu

(add-to-list 'load-path "~/dev/emacs/ecb-2.40")
(load-file "~/dev/emacs/ecb-2.40/ecb.el")

(custom-set-variables
;; custom-set-variables was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.6949152542372882
;; If there is more than one, they won't work right.
 '(ecb-layout-name "left15")
 '(ecb-layout-window-sizes (quote (("left15" (0.2564102564102564 . 0.6049152542372882) (0.2564102564102564 . 0.30728813559322035)))))
;'(ecb-windows-width 0.23)
 '(ecb-options-version "2.40")
 '(ecb-source-path (quote ("~/dev/python")))
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1))
 '(ecb-tip-of-the-day nil)
 '(ecb-tree-buffer-style (quote ascii-guides)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(python-mode-default ((t (:inherit autoface-default :height 140 :family "Inconsolata"))) t))


(require 'color-theme)
(color-theme-initialize)
(color-theme-clarity)
;;(color-theme-calm-forest)
;;(color-theme-solarized-dark)

;http://superuser.com/questions/296243/remap-command-key-in-mac-only-for-emacs
;(setq mac-control-modifier 'command)
;(setq mac-control-modifier 'meta)
;(pc-selection-mode)

;Show parenthesis
(show-paren-mode t)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Frame title bar formatting to show full path of file
(setq-default
 frame-title-format
 (list '((buffer-file-name " %f" (dired-directory
				    dired-directory
				      (revert-buffer-function " %b"
							        ("%b - Dir:  " default-directory)))))))

(setq-default
 icon-title-format
 (list '((buffer-file-name " %f" (dired-directory
                                  dired-directory
                                  (revert-buffer-function " %b"
                                  ("%b - Dir:  " default-directory)))))))

;; Org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-font-lock-mode 1)
(setq org-directory        "~/Dropbox/MobileOrg")

;; MobileOrg
(setq org-mobile-directory "~/Dropbox/MobileOrg/")
;;; Include all org files << key as it means all your org files will be parsed to the agenda.org of MobileOrg
;;(setq org-agenda-files (file-expand-wildcards "~/Dropbox/MobileOrg/*.org"))
;;; Set directory for pulling
(setq org-mobile-inbox-for-pull "~/Dropbox/MobileOrg/")

(setq org-todo-keywords
      '((type "TODO(t)" "STARTED(s)" "DONE(d)" "WAITING(w)")))