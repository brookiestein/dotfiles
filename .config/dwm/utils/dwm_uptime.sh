#!/bin/bash
# Lord Brookie
# https://github.com/brookiestein/
# MIT

dwm_uptime() {
        printf "$SEP1"
        up="$(uptime | cut -d ' ' -f 5 | cut -d ',' -f 1)"

        # Verificar si es un número entero:
        echo -en $up | grep '[[:digit:]]' > /dev/null 2>&1
        if [ $? -ne 0 ]; then
                up="$(uptime | cut -d ' ' -f 4 | cut -d ',' -f 1)"
                isdigit="False"
        else
                isdigit="True"
        fi

        # Si es un número entero, se asume que tiene menos de
        # una hora encendido el equipo.
        if [ "$isdigit" = "True" ]; then
                up="Up:0 H|$up M"
        else
                hour=$(echo $up | cut -d ':' -f 1)
                if [ $hour -lt 10 ]; then
                        up="Up:0$hour H|$(echo $up | cut -d ':' -f 2) M"
                else
                        up="Up:$hour H|$(echo $up | cut -d ':' -f 2) M"
                fi
        fi
        printf "$up"
        printf "$SEP2"
}

dwm_uptime
