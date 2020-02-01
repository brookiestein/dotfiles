#!/bin/sh

# Date is formatted like this: "[YYYY-mm-dd 00:00:00]"
function dwm_date
{
        local_date=$(date +%Y-%m-%d)
        time=$(date +%Y)
        printf "%s%s %s%s" "$SEP1" "$local_date" "$time" "$SEP2"
}

dwm_date
