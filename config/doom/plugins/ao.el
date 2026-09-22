;;; Azure Key Vault integration via the `,ao' CLI  -*- lexical-binding: t; -*-

;; Interactively copy a secret to the clipboard, or set/update a secret,
;; driving the local `,ao' tool (`,ao keyvault ...').  Secret values are read
;; with `read-passwd' and fed to the CLI on stdin, so they never touch the
;; shell history, process arguments, or the *Messages* buffer.

(defvar +ao-executable (or (executable-find ",ao")
                           (expand-file-name "~/.local/bin/,ao"))
  "Path to the `,ao' CLI executable.")

(defvar +ao--vault nil
  "Currently selected Key Vault name, cached across commands.
Reset with `+ao/select-vault'.")

(defun +ao--run (args &optional stdin)
  "Run `,ao' with ARGS (a list of strings), optionally piping STDIN.
Return stdout as a string on success.  Signal a `user-error' with the
CLI's stderr on failure.  STDIN, when non-nil, is sent to the process."
  (with-temp-buffer
    (let* ((stderr-file (make-temp-file "ao-stderr"))
           (exit (apply #'call-process-region
                        (or stdin "") nil   ; START=string → sent as stdin
                        +ao-executable
                        nil (list (current-buffer) stderr-file) nil
                        args))
           (out (buffer-string)))
      (unwind-protect
          (if (eq exit 0)
              out
            (user-error "ao %s failed: %s"
                        (string-join args " ")
                        (string-trim
                         (with-temp-buffer
                           (insert-file-contents stderr-file)
                           (buffer-string)))))
        (delete-file stderr-file)))))

(defun +ao--json (args)
  "Run `,ao' with ARGS plus --json and return the parsed result.
Arrays become lists and objects become alists."
  (json-parse-string (+ao--run (append args '("--json")))
                     :array-type 'list :object-type 'alist :null-object nil))

(defun +ao--vaults ()
  "Return the list of configured Key Vault names."
  (+ao--json '("keyvault" "list")))

(defun +ao--secret-name (entry)
  "Extract a secret name from a `secret list' JSON ENTRY.
Handles both a bare string and an alist with a `name' key."
  (cond ((stringp entry) entry)
        ((listp entry) (or (alist-get 'name entry)
                           (alist-get 'Name entry)))))

(defun +ao--secret-names (vault)
  "Return the list of secret names in VAULT."
  (delq nil (mapcar #'+ao--secret-name
                    (+ao--json (list "keyvault" "secret" "list"
                                     "--vault-name" vault)))))

(defun +ao/select-vault (&optional force)
  "Choose the active Key Vault and cache it in `+ao--vault'.
With prefix arg FORCE (or when only re-selecting), always re-prompt."
  (interactive "P")
  (when (or force (not +ao--vault))
    (setq +ao--vault
          (completing-read "Key Vault: " (+ao--vaults) nil t)))
  +ao--vault)

;;;###autoload
(defun +ao/copy-secret ()
  "Pick a secret from the active vault and copy its value to the clipboard."
  (interactive)
  (let* ((vault (+ao/select-vault))
         (name (completing-read (format "Copy secret from %s: " vault)
                                (+ao--secret-names vault) nil t))
         (value (string-trim-right
                 (+ao--run (list "keyvault" "secret" "show"
                                 "--vault-name" vault name "--value-only"))
                 "\n")))
    (kill-new value)
    (when (fboundp 'gui-set-selection)
      (gui-set-selection 'CLIPBOARD value))
    (message "Copied secret %S from %s to clipboard" name vault)))

;;;###autoload
(defun +ao/set-secret ()
  "Set (create or update) a secret in the active vault.
Offers existing secret names for completion but accepts a new name too.
The value is read hidden and sent to the CLI on stdin."
  (interactive)
  (let* ((vault (+ao/select-vault))
         (name (completing-read
                (format "Set secret in %s (name): " vault)
                (+ao--secret-names vault) nil nil))
         (_ (when (string-empty-p name) (user-error "Secret name is required")))
         (value (read-passwd (format "Value for %S: " name))))
    (+ao--run (list "keyvault" "secret" "set" "--vault-name" vault name)
              value)
    (message "Set secret %S in %s" name vault)))

(map! :leader
      (:prefix ("o" . "open")
       (:prefix ("c" . "cloud")
        :desc "Copy secret to clipboard" "c" #'+ao/copy-secret
        :desc "Set/update secret"        "s" #'+ao/set-secret
        :desc "Select key vault"         "v" #'+ao/select-vault)))

(provide 'ao)
;;; ao.el ends here
