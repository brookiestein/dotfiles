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

# Here start my personal configuration
# Colors: In there order: Red, GREEN, Blue, White and the final
colors=("\e[1;31m" "\e[1;32m" "\e[1;34m" "\e[1;37m" "\e[0m")
# Text in ASCII when start a new session.
message="| ￣￣￣￣￣￣|
| Los hackers |
| NO son |
| ciberdelincuentes |
| ＿＿＿＿＿＿＿＿ |
(__/) ||
(••) ||
/ 　 づ"

number=$(echo $(($RANDOM % 3)))

if [ $number -eq 0 ]; then
        printf "${colors[1]}"
        figlet "LORD BROOKIE"
        printf "${colors[4]}"
elif [ $number -eq 1 ]; then
        printf "${colors[2]}"
        cowsay "Hello, welcome again Lord Brookie!"
        printf "${colors[4]}"
else
        printf "${colors[3]}$message${colors[4]}\n"
fi

# Configuration of powerline.
if [ -f `which powerline-daemon` ]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bash/powerline.sh
fi

# Alias
alias p="ps aux | grep "
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias lh="ls -hs"
alias lla="ls -al"
alias llah="ls -alhs"
alias gowork="cd ~/MEGAsync/Workspace/Programming/" # Go to programming directory.
alias gogh="cd ~/MEGAsync/Workspace/Git/Hub/" # Go to GitHub directory.
