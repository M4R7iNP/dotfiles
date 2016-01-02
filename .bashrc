# Martins .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s histappend
HISTCONTROL=ignoreboth

export EDITOR=nvim

# Aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -la --color=auto'
alias la='ls -A'
alias l='ls -CF'
alias vim='vim -p'
alias nvim='nvim -p'
alias tmux='tmux -2'
alias tmuxa='tmux a'
alias e="$EDITOR"

