#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
unalias rm
alias config='/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME'
#config config status.showUntrackedFiles no

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey -s jk '\e'

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

alias vim='vim --servername vim'
alias ll='ls -l --color=auto'
alias ls='ls --color=auto'
alias sq='squeue -o "%.8i %.9P %.20j %8u %.2t %.8M %.6D %.4C %R"'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias i3lock='i3lock -c 000000'
alias sys-sleep='i3lock && systemctl suspend'

export TERMINAL="/usr/bin/xterm"
export PATH=/home/lindell/local/bin:$PATH
export PATH=~/.npm-global/bin:$PATH
export TERM="xterm-256color"
export VISUAL="vim"
export EDITOR=vim
export PATH=$PATH:/opt/anaconda/bin

#xmodmap -e "clear lock" #disable caps lock switch
#xmodmap -e "keysym Caps_Lock = Escape" #set caps_lock as escape

[ -n "$XTERM_VERSION" ] && transset-df --id "$WINDOWID" >/dev/null

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

