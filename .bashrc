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

[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# Prompt
if [ $USER != "root" ]; then
	USER_COLOR="\[\033[01;32m\]" # Green
	ARROW_COLOR="\[\033[01;31m\]" # Red
else
	USER_COLOR="\[\033[01;31m\]" # The opposite
	ARROW_COLOR="\[\033[01;32m\]"
fi

PS1="${USER_COLOR} \u \[\033[01;37m\](on \h) \[\033[01;31m\]@\[\033[01;34m\] [\w] \$\n${ARROW_COLOR} > \[\033[00m\]"
