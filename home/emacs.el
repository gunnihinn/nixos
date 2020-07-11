(require 'package)
(package-initialize)

(require 'notmuch)

(setq user-full-name "Gunnar Þór Magnússon")
(setq user-mail-address "gunnar@magnusson.io")
(setq mail-user-agent 'message-user-agent)
(setq mail-specify-envelope-from t)
(setq sendmail-program "msmtp"
	  mail-specify-envelope-from t
	  mail-envelope-from 'header
	  message-sendmail-envelope-from 'header)

(require 'use-package)

(require 'solarized)
(load-theme 'solarized-dark t)

(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(autoload 'enable-paredit-mode "paredit"
  "Turn on pseudo-structural editing of Lisp code."
  t)
(add-hook 'emacs-lisp-mode-hook       'enable-paredit-mode)
(add-hook 'lisp-mode-hook             'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook 'enable-paredit-mode)
(add-hook 'scheme-mode-hook           'enable-paredit-mode)

(use-package graphviz-dot-mode
  :ensure t
  :config
  (setq graphviz-dot-indent-width 4))

(use-package company-graphviz-dot)

(add-hook 'before-save-hook 'gofmt-before-save)

(add-hook 'visual-line-mode-hook #'visual-fill-column-mode)
(setq visual-fill-column-center-text t)
(set-fill-column 80)

(add-hook 'after-init-hook 'global-company-mode)

(use-package projectile
  :commands projectile-mode
  :bind-keymap* (("C-c p" . projectile-command-map)
                 ("s-p" . projectile-command-map))
  :bind (("C-c C-f" . projectile-find-file))
  :preface
  ;(autoload 'projectile-project-vcs "projectile")
  ;(autoload 'projectile-project-root "projectile")
  ;(autoload 'easy-menu-define "easymenu" "" nil 'macro)
  :demand
  :config
  (projectile-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default)))
 '(send-mail-function (quote sendmail-send-it)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 158 :width normal)))))
