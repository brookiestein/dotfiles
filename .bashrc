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
red="\e[1;31m"
green="\e[1;32m"
blue="\e[1;34m"
white="\e[1;37m"
end="\e[0m"
message="| ￣￣￣￣￣￣|
| Los hackers |
| NO son |
| ciberdelincuentes |
| ＿＿＿＿＿＿＿＿ |
(__/) ||
(••) ||
/ 　 づ"

number=`echo $(($RANDOM % 3))`
if [ $number -eq 0 ]; then
        echo -en "$green"
        figlet "LORD BROOKIE"
        echo -en "$end"
elif [ $number -eq 1 ]; then
        echo -en "$blue"
        cowsay "Hello, welcome again Lord Brookie!"
        echo -en "$end"
else
        echo -en "$white" "\b$message" "\b$end\n"
fi

# Powerline settings
if [ -f `which powerline-daemon` ]; then
        powerline-daemon -q
        POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
        . /usr/share/powerline/bash/powerline.sh
else
        echo -n "$red"
        echo "An error occurred while the powerline configuration"
        echo "was being charged."
        echo -n "$end"
fi

# Aliases
alias l="ls"
alias la="ls -a"
alias ll="ls -l"
alias gowork="cd ~/MEGAsync/Workspace/Programming/" # Go to Programming directory.
alias gogh="cd ~/MEGAsync/Workspace/Git/Hub/" # Go to GitHub directory.
alias music="youtube-dl -x --audio-format aac --audio-quality 9" # Download music from YouTube.
alias vgaoff="xrandr --output VGA-1 --off" # Shutdown the secondary monitor.
# Common options to qemu.
alias qemu64="qemu-system-x86_64 \
-cpu host -soundhw hda -enable-kvm \
-device e1000,netdev=network0,mac=52:55:00:d1:55:01 \
-netdev tap,id=network0,ifname=tap0,script=no,downscript=no -vga std"
