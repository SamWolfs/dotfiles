if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export LOCAL="$HOME/.local/bin"
export ZSH="$HOME/.oh-my-zsh"
export DOOM="$HOME/.emacs.d/bin"
export EDITOR="emacs"

export PATH=$LOCAL/android-studio/bin:$GOPATH/bin:$LOCAL:$DOOM:$PATH

export GCM_CREDENTIAL_STORE="gpg"

# zsh
#ZSH_THEME="gruvbox"
#plugins=(git history fzf)
#source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

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

alias zshrc='vim ~/.zshrc'
alias vimrc='vim ~/.vimrc'
alias i3config='vim ~/.config/i3/config'
alias kittyconf='vim ~/.config/kitty/kitty.conf'

alias pls=please
alias please='sudo $(fc -ln -1)'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
