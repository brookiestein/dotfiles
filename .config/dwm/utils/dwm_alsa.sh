#!/bin/sh

# Modified by Lord Brookie
# https://github.com/brookiestein/
# Credits to:
#
# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: alsa-utils

dwm_alsa () {
        printf "$SEP1 "
        state=$(amixer get Master | tail -n 1 | cut -d ' ' -f 8)
        if [ $state = "[on]" ]; then
                vol=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
                printf "%s%%%s" $vol $SEP2
        else
                vol="Muted"
                printf "%s%s" $vol $SEP2
        fi
}

dwm_alsa
