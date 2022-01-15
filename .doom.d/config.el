;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Sam Wolfs"
      user-mail-address "be.samwolfs@gmail.com")

(setq doom-theme 'doom-gruvbox)
(setq doom-unicode-font (font-spec :family "MesloLGS NF"))

(setq org-directory "~/dev/org/")

(setq display-line-numbers-type 'relative
      scroll-margin 8)

(setq projectile-project-search-path '(("~/dev/workspaces/" . 2)))

(require 'asdf)

(require 'ob-typescript)
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

(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

