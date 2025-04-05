#!/bin/sh

case "$1" in
  pre)
    sudo -u brayan \
      XDG_RUNTIME_DIR=/run/user/$(id -u brayan) \
      swaylock -f -i /home/brayan/Wallpapers/finn_jake_marceline_princess_bubblegum_bmo_hd_adventure_time.jpg -s fill &
    sleep 1
    ;;
esac
