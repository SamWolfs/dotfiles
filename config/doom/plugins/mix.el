;;; Elixir / Mix task runner

(defun +elixir--project-root ()
  "Return the root of the current Mix project, or nil if not in one."
  (or (and (fboundp 'projectile-project-root) (projectile-project-root))
      (locate-dominating-file default-directory "mix.exs")))

(defun +elixir/mix (task)
  "Run `mix TASK' from the current project's root in a *mix* buffer.
Called interactively, prompts for the task (e.g. \"deps.get\")."
  (interactive "smix ")
  (let* ((root (or (+elixir--project-root)
                   (user-error "Not inside a Mix project (no mix.exs found)")))
         (default-directory root)
         (compilation-buffer-name-function (lambda (_) "*mix*")))
    (compile (concat "mix " task))))

(defun +elixir/compile ()          (interactive) (+elixir/mix "compile"))
(defun +elixir/clean ()            (interactive) (+elixir/mix "clean"))
(defun +elixir/deps-get ()         (interactive) (+elixir/mix "deps.get"))
(defun +elixir/deps-update-all ()  (interactive) (+elixir/mix "deps.update --all"))
(defun +elixir/deps-update (dep)
  "Update a single dependency DEP via `mix deps.update'."
  (interactive "sDependency to update: ")
  (+elixir/mix (concat "deps.update " dep)))
(defun +elixir/deps-clean-unused () (interactive) (+elixir/mix "deps.clean --unused"))
(defun +elixir/deps-tree ()        (interactive) (+elixir/mix "deps.tree"))

(map! :after elixir-mode
      :map elixir-mode-map
      :localleader
      "f" #'elixir-format
      "m" #'+elixir/mix
      "c" #'+elixir/compile
      "x" #'+elixir/clean
      (:prefix ("d" . "deps")
       "g" #'+elixir/deps-get
       "u" #'+elixir/deps-update-all
       "U" #'+elixir/deps-update
       "c" #'+elixir/deps-clean-unused
       "t" #'+elixir/deps-tree))
