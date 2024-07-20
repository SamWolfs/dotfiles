;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Sam Wolfs"
      user-mail-address "be.samwolfs@gmail.com")

(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font Mono"))

(setq org-directory "~/dev/org/")
(setq org-roam-dailies-directory "journal/")

(setq org-roam-dailies-capture-template
      '(("d" "default" entry "* %<%k:%M:%S %z>: %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

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
    (add-to-list 'exec-path "~/dev/tools/elixir-ls"))

(setenv "GCM_CREDENTIAL_STORE" "gpg")

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

(map! :after elixir-mode
      :map elixir-mode-map
      :localleader
      "f" #'elixir-format)

(map! :after go-mode
      :localleader
      :map go-mode-map
      "f" #'gofmt)

(map! :after rust
      :localleader
      :map rust-mode-map
      "SPC m f" #'rustic-format-buffer)

(setq shell-file-name "~/.nix-profile/bin/zsh")

(setq evil-want-Y-yank-to-eol t)
;; same ciw functionality as vim
(defadvice evil-inner-word (around underscore-as-word activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (with-syntax-table table
      ad-do-it)))

(load-file "~/.config/doom/secret.el")
