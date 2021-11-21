;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sam Wolfs"
      user-mail-address "be.samwolfs@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)
(setq doom-unicode-font (font-spec :family "MesloLGS NF"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/dev/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative
      scroll-margin 8)

(setq projectile-project-search-path '(("~/dev/workspaces/" . 2)))

(require 'asdf)
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(use-package lsp-mode
    :commands lsp
    :ensure t
    :diminish lsp-mode
    :hook
    (elixir-mode . lsp)
    :init
    (add-to-list 'exec-path "/home/swo/dev/ls/elixir-ls"))

(add-hook 'org-present-mode-hook (lambda ()
                        (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                (header-line (:height 4.5) variable-pitch)
                                (org-document-title (:height 1.75) org-document-title)
                                (org-code (:height 1.55) org-code)
                                (org-verbatim (:height 1.55) org-verbatim)
                                (org-block (:height 1.25) org-block)
                                (org-block-begin-line (:height 0.7) org-block)))
                        (setq header-line-format " ")
                        (org-display-inline-images)))

(add-hook 'org-present-mode-quit-hook (lambda ()
                                        (setq-local face-remapping-alist '((default variable-pitch default)))
                                        (setq header-line-format nil)
                                        (org-present-small)
                                        (org-remove-inline-images)))

(map! :map general-override-mode-map :nv "s" #'evil-substitute)

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)
