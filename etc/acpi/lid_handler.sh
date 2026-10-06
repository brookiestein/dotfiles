#!/bin/sh

USER=khronos
RUNTIME_DIR=/run/user/`id -u ${USER}`
WD=$(basename $(ls -1 ${RUNTIME_DIR}/wayland-[0-9]* 2>/dev/null | head -n 1))

case "$*" in
    *close*)
	su - -c "XDG_RUNTIME_DIR=${RUNTIME_DIR} WAYLAND_DISPLAY=${WD} hyprlock" ${USER} &
	echo mem > /sys/power/state
	;;
    *open*)
	;;
esac
