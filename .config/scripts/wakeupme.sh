#!/bin/bash

RED="\e[1;31m"
ORANGE="\e[1;33m"
WHITE="\e[1;37m"
END="\e[0m"

usage()
{
        printf "${WHITE}Usage:\n$0: 30 minutes.$END\n"
        printf "Where ${ORANGE}30${END} is the amount of minutes you want to be woke up.\n"
}

[ $# -lt 1 ] && usage && exit 1

for ((i=$(($1*60));i>0;i--)); do
        colour=$WHITE
        if [ $i -lt 15 ]; then
                colour=$RED
        elif [ $i -lt 61 ]; then
                colour=$ORANGE
        fi
        printf "${colour}You will be woke up in $i seconds.$END\r"
        sleep 1
done

# Verifying if the volume is muted.
state=`amixer get Master | tail -n 1 | cut -d ' ' -f 8`
[ $state == "[off]" ] && amixer -q -D pulse sset Master toggle

# Setting it to 100% if it's not established.
# Notice that amixer won't up this more than 100%
state=`amixer get Master | tail -n 1 | cut -d ' ' -f 7`
[ $state != "[100%]" ] && amixer -q sset Master 100%+

# Put here your favourite multimedia reproductor and music.
# e.g.
vlc ~/Music/your_very_fun_music.ogg
