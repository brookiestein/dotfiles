#!/bin/sh

case "$*" in
    *close*)
	su - -c 'DISPLAY=:0 /usr/local/bin/slock' brayan &
	echo mem > /sys/power/state
	;;
    *open*)
	;;
esac
