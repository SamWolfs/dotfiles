export NPM_BIN="$XDG_CACHE_HOME/npm/bin"
export QL_DIR="$HOME/quicklisp/local-projects"

export PATH="$NPM_BIN:$HOME/.mix/escripts:$GOPATH/bin:$LOCAL:$DOOM:$PATH"

export GCM_CREDENTIAL_STORE="gpg"

export ERL_AFLAGS="-kernel shell_history enabled"

export LANG=en_US.UTF-8

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# Only run if the shell is interactive
if [[ $- =~ i ]]; then
    # Check that we are NOT in Emacs and NOT already in tmux
    if [[ -z "$INSIDE_EMACS" && -z "$TMUX" ]]; then
        if command -v tmux >/dev/null 2>&1; then
            exec tmux new-session -A -s main
        fi
    fi
fi

[[ -f "$XDG_CONFIG_HOME/zsh/host.zsh" ]] && source "$XDG_CONFIG_HOME/zsh/host.zsh"
