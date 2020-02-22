#!/bin/sh

# Date is formatted like this: "[day YYYY-mm-dd 00:00:00]"
function dwm_date
{
        day=$(date +%a)
        local_date=$(date +%Y-%m-%d)
        time=$(date +%T)
        printf "%s%s %s%s%s" "$SEP1" "$day" "$local_date" "$time" "$SEP2"
}

dwm_date
