;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.
(package! bazel :recipe (:host github :repo "bazelbuild/emacs-bazel-mode"))
(package! catppuccin-theme)
(package! claude-code-ide :recipe (:host github :repo "manzaltu/claude-code-ide.el"))
(package! exec-path-from-shell)
(package! exunit)
(package! fennel-mode :recipe (:host gitlab :repo "technomancy/fennel-mode" :files ("fennel-mode.el")))
(package! ijanet-mode :recipe (:host github :repo "SerialDev/ijanet-mode" :files ("ijanet.el")))
(package! janet-mode :recipe (:host github :repo "ALSchwalm/janet-mode"))
(package! mermaid-mode :recipe (:host github :repo "abrochard/mermaid-mode"))
(package! jsonnet-mode)
(package! ob-jsonnet :recipe (:host github :repo "SamWolfs/ob-jsonnet"))
(package! ob-typescript)
(package! obsidian)
(package! org-present)
(package! ox-reveal)
(package! protobuf-mode)
(package! typescript-mode)
(package! wakatime-mode)
