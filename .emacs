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
 '(compilation-search-path (quote (nil)))
 '(compilation-window-height 8)
 '(delete-selection-mode nil nil (delsel))
 '(file-coding-system-alist (quote (("\\.elc\\'" emacs-mule . emacs-mule) ("\\(\\`\\|/\\)loaddefs.el\\'" raw-text . raw-text-unix) ("\\.tar\\'" no-conversion . no-conversion) ("" utf-8 . utf-8))))
 '(fill-column 72)
 '(mark-even-if-inactive t)
 '(menu-bar-mode nil)
 '(scroll-bar-mode (quote right))
 '(sh-basic-offset 8)
 '(sh-indent-comment t)
 '(sh-indentation 8)
 '(show-paren-mode t)
 '(tool-bar-button-margin 1 t)
 '(tool-bar-mode nil nil (tool-bar))
 '(tooltip-mode t nil (tooltip)))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "DarkBlue")))))

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

;; WeST

(setq auto-mode-alist (cons '("Makefile.*" . makefile-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.stu$" . shell-script-mode) auto-mode-alist))

; Matlab Mode.                                                                                                                                     
;; Replace path below to be where your matlab.el file is.                                                                                          
(add-to-list 'load-path "/home/kunegis/Archiv/bin/matlab-el/")
(load-library "matlab-load")

;; Ubuntu input method bug  
;; https://www.emacswiki.org/emacs/DeadKeys
; (require 'iso-transl) ; works for some combinations, not all

;(defun set-window-undedicated-p (window flag)
; "Never set window dedicated."
; flag)

; (advice-add 'set-window-dedicated-p :override #'set-window-undedicated-p)

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (let ((inhibit-read-only t))
    (ansi-color-apply-on-region (point-min) (point-max))))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(setq compile-command "nice stu")

