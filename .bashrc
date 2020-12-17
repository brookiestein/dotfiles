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
RED="\e[1;31m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
WHITE="\e[1;37m"
NOCLOR="\e[0m"
MESSAGE="|             |
| Los hackers |
| NO son |
| ciberdelincuentes |
|                  |
(__/) ||
(••) ||
/      "

number=`echo $(($RANDOM % 3))`
if [ $number -eq 0 ]; then
        echo -en "$GREEN"
        figlet "LORD BROOKIE"
        echo -en "$NOCOLOR"
elif [ $number -eq 1 ]; then
        echo -en "$BLUE"
        cowsay "Hello, welcome again Lord Brookie!"
        echo -en "$NOCOLOR"
else
        echo -e "${WHITE}${MESSAGE}${NOCOLOR}"
fi

# Powerline settings
if [ -f `which powerline-daemon` ]; then
        powerline-daemon -q
        POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
        . /usr/share/powerline/bash/powerline.sh
else
        echo -n "$RED"
        echo "An error occurred while the powerline configuration"
        echo "was being charged."
        echo -n "$NOCOLOR"
fi

export PATH="${PATH}:${HOME}/.config/scripts"

# Aliases
# Gentoo-specific
alias search="emerge --search"

# System-agnostic
alias ls="ls --color=auto --classify"
alias la="ls --color=auto --almost-all"
alias ll="ls --color=auto --author -l"
alias cp="cp --verbose --interactive"
alias rm="rm --verbose"
alias mv="mv --verbose --interactive"
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias untar="tar --verbose --preserve-permissions --extract --file"

# Some useful aliases for daily working.
alias gtw="cd ${HOME}/MEGAsync/Workspace/Programming/" # Go to Programming directory.
alias gth="cd ${HOME}/MEGAsync/Workspace/Git/Hub/" # Go to GitHub directory.
alias vgaoff="xrandr --output VGA-1 --off" # Shutdown the secondary monitor.
# Turn on the secondary monitor.
# Notice that I can use this command as is, because I've added my scripts
# directory to the PATH variable.
alias vgaon="resolution"
