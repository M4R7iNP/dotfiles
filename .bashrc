# Martins .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

shopt -s histappend
HISTCONTROL=ignoreboth

export PATH="$HOME/.local/bin:$PATH"

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
alias chperm='sudo chown martin:adm . -R && sudo chmod ug=rwX,o= . -R'
alias edit="$EDITOR"
alias e=edit
alias sudo='sudo '
alias ..='cd ..'
alias ....='cd ../..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias ..4='cd ../../../..'

# reload bashrc
resource() {
    source ~/.bashrc
}

# wrap command in «git stash»
stashwrap() {
    cmd="$@"
    git stash
    $cmd
    git stash pop
}

# port forwarding
portforward() {
    from="$1"
    to="$2"

    echo "http://$HOSTNAME:$from will now point to port $to"

    socat "TCP-LISTEN:$from,fork" "TCP:127.0.0.1:$to"
}
