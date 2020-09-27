#!/bin/sh
# Line 4 and 5 are for Java programs
# to start without problems. (In theory)
export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D

# Keyboard layout by default, see config.h for know some key bindings for change this
setxkbmap -layout us -variant intl

# For this to work you need to have acpi installed
[ `acpi --ac-adapter | cut -d ' ' -f 3` == "on-line" ] && xbacklight -set 100 || xbacklight -set 50

# If there is a monitor connected by VGA (in my case) with a resolution of 1280x1024
# configure this with a little script localized in:
/home/brookie/.config/scripts/resolution.sh
# Disable DPMS
/home/brookie/.config/scripts/disable_dpms.sh

# Wallpaper
feh --no-fehbg --bg-fill '/home/brookie/MEGAsync/Wallpapers/PC/wallhaven-2evglg_3840x2160.png'

slstatus &
xfce4-clipman &
dunst &
mega-cmd-server
pulseaudio --start
compton --backend glx --paint-on-overlay --vsync opengl-swc &
spm --daemon --monitor --verbose --file=/tmp/spm.log

exec /usr/bin/dwm
