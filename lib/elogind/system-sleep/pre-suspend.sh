#!/bin/sh

case "$1" in
  pre)
    su - -c \
      "XDG_RUNTIME_DIR=/run/user/1000 /usr/bin/swaylock -f -i /home/brayan/Wallpapers/finn_jake_marceline_princess_bubblegum_bmo_hd_adventure_time.jpg -s fill" brayan &
    sleep 1
    ;;
esac
