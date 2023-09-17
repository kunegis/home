;;
;; The '.emacs' file of Jérôme Kunegis. 
;;

;; global

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-raise-tool-bar-buttons t t)
 '(auto-resize-tool-bars t t)
 '(blink-cursor-mode nil)
 '(c-basic-offset 8)
 '(column-number-mode t)
 '(compilation-error-screen-columns t)
 '(compilation-scroll-output t)
 '(compilation-search-path '(nil))
 '(compilation-window-height 8)
 '(delete-selection-mode nil nil (delsel))
 '(file-coding-system-alist
   '(("\\.elc\\'" emacs-mule . emacs-mule)
     ("\\(\\`\\|/\\)loaddefs.el\\'" raw-text . raw-text-unix)
     ("\\.tar\\'" no-conversion . no-conversion)
     ("" utf-8 . utf-8)))
 '(fill-column 80)
 '(font-lock-global-modes '(not speedbar-mode))
 '(mark-even-if-inactive t)
 '(menu-bar-mode nil)
 '(safe-local-variable-values
   '((vc-prepare-patches-separately)
     (diff-add-log-use-relative-names . t)
     (vc-git-annotate-switches . "-w")))
 '(scroll-bar-mode 'right)
 '(sh-basic-offset 8)
 '(sh-indent-comment 0)
 '(sh-indentation 8)
 '(show-paren-mode t)
 '(todoo-indent-column 0)
 '(todoo-sub-item-marker "**")
 '(tool-bar-button-margin 1 t)
 '(tool-bar-mode nil nil (tool-bar))
 '(tooltip-mode t nil (tooltip)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :background "gray21" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "SRC" :family "Hack"))))
 '(compilation-error ((t (:foreground "chocolate1"))))
 '(custom-comment ((t (:background "cyan"))))
 '(dired-ignored ((t (:inherit shadow :foreground "gray47"))))
 '(dired-mark ((t (:foreground "deep sky blue"))))
 '(dired-marked ((t (:foreground "chartreuse"))))
 '(error ((t (:foreground "brown1"))))
 '(font-lock-builtin-face ((t (:foreground "deep sky blue"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "light coral"))))
 '(font-lock-comment-face ((t (:foreground "light coral"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "DarkBlue"))))
 '(hl-line ((t (:background "gray6"))))
 '(region ((t (:extend t :background "dim gray"))))
 '(todoo-item-header-face ((t (:foreground "goldenrod")))))

(global-font-lock-mode 1)
(setq font-lock-maximum-decoration t)
(setq column-number-mode t)
(setq frame-title-format (concat "Emacs"))

(defun jay-switch-cc-hh () (interactive)
  (let ((current-buf-name (buffer-file-name (current-buffer))))
    (if (stringp current-buf-name)
 (let ((match-h (string-match "\\.hh$" buffer-file-name)))
	  (if (or match-h
		  (string-match "\\.cc$" buffer-file-name))
	      (if match-h
		  (find-file (concat (substring buffer-file-name 0 -3) ".cc"))
		(find-file (concat (substring buffer-file-name 0 -3) ".hh")))
	    (error "Not a C++ file")))
	  (error "Not a C++ file"))))

(defun jay-goto-comp ()    (interactive) (switch-to-buffer "*compilation*"))

(global-set-key [f2] 'comment-or-uncomment-region)
(global-set-key [f3] 'goto-line)
(global-set-key [f4] 'shell)
(global-set-key [f5] 'jay-switch-cc-hh)
(global-set-key [f6] 'auto-fill-mode)
(global-set-key [f7] 'fill-region) 
(global-set-key [f8] 'compilation-mode)
(global-set-key [f9] 'compile) 
(global-set-key [f10] 'indent-region)
(global-set-key [f11] 'next-error)
(global-set-key [f12] 'jay-goto-comp)

(setq auto-mode-alist (cons '("Makefile.*" . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.stu$" . shell-script-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq compile-command "stu")

(add-hook 'sh-mode-hook
	  (lambda ()
	    (setq-default comment-start "##")))
(add-hook 'sh-mode-hook
	  (lambda ()
	    (setq comment-start "##")))

; Highlight the current line
; from https://emacsredux.com/blog/2013/04/02/highlight-current-line/
(global-hl-line-mode +1)

; (set-frame-font "Fantasque Sans Mono 16" nil t)
(set-frame-font "Hack 12" nil t)

(load-theme 'deeper-blue t)

(set-default-file-modes ?\700)

; (set-face-background 'scroll-bar "darkgrey")
