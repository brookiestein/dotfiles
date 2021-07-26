#!/bin/sh
export CM_SELECTIONS="clipboard"
export CM_HISTLENGTH=1000
# For Java graphic programs to be drawn correctly.
export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D

xset -dpms # Disable DPMS
xset s off # Disable screensaver
xset s noblank # Disable screen blank

[ $(ps -aux | grep ssh-agent | wc -l) -gt 1 ] && killall ssh-agent

ssh-agent -s | sed 's/echo/#echo/g' > ~/.ssh/agent.env
chmod 600 ~/.ssh/agent.env
. ~/.ssh/agent.env

xrdb ~/.Xresources
exec dbus-launch --exit-with-session /usr/local/bin/dwm
