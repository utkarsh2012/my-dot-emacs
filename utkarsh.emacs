;; This is the Aquamacs Preferences file.
;; Add Emacs-Lisp code here that should be executed whenever
;; you start Aquamacs Emacs. If errors occur, Aquamacs will stop
;; evaluating this file and print errors in the *Messags* buffer.
;; Use this file in place of ~/.emacs (which is loaded as well.)

(setq inhibit-splash-screen t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
;(load-file "~/dev/emacs/emacs-for-python/epy-init.el")

(add-to-list 'load-path "~/dev/emacs/emacs-for-python") ;; tell where to load the various files
(require 'epy-setup) ;; It will setup other loads, it is required!
;(require 'epy-python) ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing) ;; For configurations related to editing [optional]
;(require 'epy-bindings) ;; For my suggested keybindings [optional]


;No backup file (~)
(setq make-backup-files nil)

;Line number
;(require 'linum)
;(global-linum-mode)

(add-to-list 'load-path "~/dev/emacs")

; For Solarized theme
(add-to-list 'load-path "~/dev/emacs/emacs-color-theme-solarized")
(require 'color-theme-solarized)

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
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

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
;(color-theme-calm-forest)
(color-theme-solarized-dark)

(defun my-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name))))
(setq compilation-scroll-output t)
(local-set-key "\C-c\C-c" 'my-compile)
