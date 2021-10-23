#!/bin/sh

# Put here your music (the path)
music=""

# I usually listen to a soundtrack (a music with no letters :P)
mpv --loop --really-quiet $music &
# See https://github.com/brookiestein/timer
# Or use whatever timer you like
timer --hours=2
# In case you have more than one instances of mpv
pidof mpv | awk '{print $1}' | xargs kill
