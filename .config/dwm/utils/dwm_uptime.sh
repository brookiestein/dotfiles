#!/bin/bash
# Lord Brookie
# https://github.com/brookiestein/
# MIT

dwm_uptime() {
        printf "$SEP1"
        up="$(uptime | cut -d ' ' -f 5 | cut -d ',' -f 1)"
        if [ $up = "day" ]; then
                day="$(uptime | cut -d ' ' -f 4 | cut -d ',' -f 1)"
                up="$(uptime | cut -d ' ' -f 6 | cut -d ',' -f 1)"

                echo $up | grep ":" > /dev/null 2>&1
                if [ $? -eq 0 ]; then
                        hour=$(echo $up | cut -d ':' -f 1)
                        echo -en $hour | grep '[[:digit:]]' > /dev/null 2>&1
                        if [ $? -ne 0 ]; then
                                hour=0
                        fi
                else
                        hour=0
                fi

                min=$(echo $up | cut -d ':' -f 2)
                up="Up:$day D|$hour H|$min M"
        else
                echo -en $up | grep '[[:digit:]]' > /dev/null 2>&1
                if [ $? -ne 0 ]; then
                        up="$(uptime | cut -d ' ' -f 4 | cut -d ',' -f 1)"
                fi

                # Si tiene dos puntos, se asume que tiene más de 10
                # horas encendido.
                echo $up | grep : > /dev/null 2>&1
                if [ $? -eq 0 ]; then
                        isdigit="False"
                else
                        isdigit="True"
                fi

                # Si no es un número entero, se asume que tiene menos de
                # una hora encendido el equipo.
                if [ "$isdigit" = "True" ]; then
                        up="Up:0 D|0 H|$up M"
                else
                        hour=$(echo $up | cut -d ':' -f 1)
                        min=$(echo $up | cut -d ':' -f 2)
                        up="Up:0 D|$hour H|$min M"
                fi
        fi
        printf "$up"
        printf "$SEP2"
}

dwm_uptime
