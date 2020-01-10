#!/bin/sh

# A dwm_bar function to show the master volume of ALSA
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: alsa-utils

dwm_alsa () {
        VOL=$(amixer get Master | tail -n1 | sed -r "s/.*\[(.*)%\].*/\1/")
        printf "%s" "$SEP1"
        if [ "$VOL" -eq 0 ]; then
                printf "V:"
        elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
                rintf "V:%s%%" "$VOL"
        elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
                printf "V:%s%%" "$VOL"
        else
                printf "V:%s%%" "$VOL"
        fi
        printf "%s\n" "$SEP2"
}

dwm_alsa
