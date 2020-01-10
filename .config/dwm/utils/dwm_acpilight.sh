#!/bin/bash
# Lord Brookie
# https://github.com/brookiestein
# MIT

dwm_acpilight() {
        printf "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
                percent="$(xbacklight -get)"
                if [ $percent -lt 15 ]; then
                        printf "🌕 $percent"
                elif [ $percent -lt 25 ]; then
                        printf "🌔 $percent"
                elif [ $percent -lt 50 ]; then
                        printf "🌓 $percent"
                elif [ $percent -lt 75 ]; then
                        printf "🌒 $percent"
                else
                        printf "🌑 $percent"
                fi
        else
                percent="$(xbacklight -get)"
                printf "$percent"
        fi
        printf "$SEP2"
}

dwm_acpilight
