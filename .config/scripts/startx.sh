#!/bin/bash
# Use it like: ./startx.sh [dwm|mate] [-v]

VERBOSE=1
RED="\e[1;31m"
NOCOLOR="\e[0m"

if [ "$1" == "dwm" ]; then
        sed -i 's/mate-session/\/usr\/bin\/dwm/g' ~/.xinitrc
elif [ "$1" == "mate" ]; then
        sed -i 's/\/usr\/bin\/dwm/mate-session/g' ~/.xinitrc
else
        echo -e "${RED}The graphic environment '$1' was not recognised.${NOCOLOR}"
        exit 1
fi

for i in $@; do
        [ $i == "-v" ] && VERBOSE=0
done

[ $VERBOSE ] && echo "Launching $1"
startx
