# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
        # Shell is non-interactive.  Be done now!
        return
fi

# Put your fun stuff here.
# Aliases
alias ls="ls --color=auto --classify"
alias l="ls"
alias la="ls --almost-all"
alias ll="ls -l"
alias cp="cp --verbose --interactive"
alias mv="mv --verbose --interactive"
alias rm="rm --verbose"
alias mkdir="mkdir --parent --verbose"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias untar="tar --verbose --preserve-permissions --extract --file"
alias gtw="cd ${HOME}/MEGAsync/Workspace/Programming/"
alias start="startx"
alias ga="git add"
alias gis="git status"
alias gf="git diff"
alias gp="git push"
alias gip="git pull"

p="bluetoothctl"
alias bton="$p power on"
alias btoff="$p power off"
alias cnbt="$p connect $MS"
alias dcnbt="$p disconnect $MS"
unset p
# Prompt
PS1="\[\033[01;32m\] \u \[\033[01;31m\]@\[\033[01;34m\] [\w] \$\n\[\033[1;31m\] > \[\033[00m"
