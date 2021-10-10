if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/swo/.oh-my-zsh"
export DOOM="/home/swo/.emacs.d/bin"
export PATH=$DOOM:$PATH

ZSH_THEME="gruvbox"
ZSH_TMUX_AUTOSTART="true"
ZSH_TMUX_AUTOQUIT="true"

plugins=(asdf git tmux history fzf)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
alias i3config='vim ~/.i3/config'
alias tmuxconf='vim ~/.tmux.conf'

alias pls=please
alias please='sudo $(fc -ln -1)'

setxkbmap -layout us -variant intl
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
