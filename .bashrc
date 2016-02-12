# Martins .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s histappend
HISTCONTROL=ignoreboth

NVIM_LOCATION=$(which nvim >/dev/null 2>/dev/null)
if [ "$?" = "0" ];
then
    EDITOR=nvim
else
    EDITOR=vim
fi

export EDITOR="$EDITOR"

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
alias edit="$EDITOR"
alias e=edit

if [ "$EDITOR" = "nvim" ];
then
    alias vim=vim_to_nvim
    vim_to_nvim() {
        echo "NEI NEI NEI! Skriv «e $@»";
    }
fi
