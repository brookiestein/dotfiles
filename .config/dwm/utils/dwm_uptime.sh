#!/bin/bash
# Lord Brookie
# https://github.com/brookiestein/
# MIT

dwm_uptime() {
        printf "$SEP1"
        up="$(uptime | cut -d ' ' -f 5 | cut -d ',' -f 1)"
        hour=$(echo $up | cut -d ':' -f 1)
        if [ $hour -lt 10 ]; then
                up="Up:0$hour H|$(echo $up | cut -d ':' -f 2) M"
        else
                up="Up:$hour H|$(echo $up | cut -d ':' -f 2) M"
        fi
        printf "$up"
        printf "$SEP2"
}

dwm_uptime
