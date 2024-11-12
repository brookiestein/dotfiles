#!/bin/bash

get_battery_info() {
	local capacity=$(cat /sys/class/power_supply/BAT0/capacity)
	local status=$(cat /sys/class/power_supply/BAT0/status)

	if [ $status = "Discharging" ]; then
		status="(-)"
	elif [ $status = "Charging" ]; then
		status="(+)"
	else
		status="(?)"
	fi

	battery_info="${capacity}${status}"
}

get_volume() {
	volume=$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $3;}')
	microphone=$(wpctl get-volume @DEFAULT_SOURCE@ | awk '{print $3;}')
	if [ "${volume}" != "[MUTED]" ]; then
		volume="$(wpctl get-volume @DEFAULT_SINK@ | awk '{print $2;}' | cut -d '.' -f 2)%"
	fi

	if [ "${microphone}" != "[MUTED]" ]; then
		microphone="$(wpctl get-volume @DEFAULT_SOURCE@ | awk '{print $2;}' | cut -d '.' -f 2)%"
	fi
}

while true; do
	get_volume
	get_battery_info
	date=$(date +'%A, %F')
	time=$(date +'%T')

	echo "Bat: $battery_info | Vol: $volume, Mic: $microphone | Date: $date | $time"
	sleep 1
done
