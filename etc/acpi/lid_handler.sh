#!/bin/sh

case "$3" in
    close)
	echo mem > /sys/power/state
	;;
    open)
	;;
esac
