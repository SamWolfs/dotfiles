if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export LOCAL="$HOME/.local/bin"
# export ZSH="$HOME/.oh-my-zsh"
export DOOM="$HOME/.config/emacs/bin"
export EDITOR="emacs"
export GOPATH="$HOME/go"
# Alternative to GOPATH
# $(go env GOPATH)
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

alias k="kubectl"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias shutdown='sudo shutdown now'
alias restart='sudo restart now'

alias l='ls -lFh'
alias la='ls -lAFh'
alias lr='ls -tRFh'
alias lt='ls -ltFh'
alias ll='ls -l'
alias ldot='ls -ld .*'
alias lS='ls -1FSsh'
alias lart='ls -1Fcart'
alias lrt='ls -1Fcrt'

alias update-profile="home-manager switch --flake $HOME/nix#$USER";

alias pls=please
alias please='sudo $(fc -ln -1)'

source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
