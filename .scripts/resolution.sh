#!/bin/bash
status="$(xrandr | grep VGA | cut -d ' ' -f 2)"
if [ "$status" = "connected" ]; then
        xrandr --output LVDS-1 --auto --primary
        xrandr --output VGA-1 --auto --right-of LVDS-1 --mode 1280x1024
fi
