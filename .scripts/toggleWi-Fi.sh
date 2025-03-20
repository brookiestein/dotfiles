#!/bin/bash

action=
message=

if [ `systemctl status wpa_supplicant@wlp3s0.service | grep Active | awk '{print $2;}'` = "active" ]; then
	action="stop"
	message="Wi-Fi stopped."
else
	action="start"
	message="Wi-Fi started."
fi

sudo systemctl $action wpa_supplicant@wlp3s0 dhcpcd
notify-send "Wi-Fi Toggler" "${message}"
