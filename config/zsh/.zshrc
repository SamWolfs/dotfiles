if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export NPM_BIN="$HOME/.npm-packages/bin"
export QL_DIR="$HOME/quicklisp/local-projects"

export PATH="$NPM_BIN:$HOME/.mix/escripts:$GOPATH/bin:$LOCAL:$DOOM:$PATH"

export GCM_CREDENTIAL_STORE="gpg"

export ERL_AFLAGS="-kernel shell_history enabled"

# zsh
# ZSH_THEME="gruvbox"
# plugins=(direnv git history fzf)
# source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
