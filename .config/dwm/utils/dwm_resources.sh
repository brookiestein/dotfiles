#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

dwm_resources () {
        # Used and total memory
        MEMUSED=$(free -h | awk '(NR == 2) {print $3}')
        MEMTOT=$(free -h |awk '(NR == 2) {print $2}')
        # CPU percentage of use
        CPUSED=$(awk -v a="$(awk '/cpu /{print $2+$4,$2+$4+$5}' /proc/stat; sleep 1)" \
                '/cpu /{split(a,b," "); print 100*($2+$4-b[1])/($2+$4+$5-b[2])}' \
                /proc/stat)
        # Used and total storage in /home (rounded to 1024B)
        # STOUSED=$(df -h | grep '/home$' | awk '{print $3}')
        # STOTOT=$(df -h | grep '/home$' | awk '{print $2}')
        # STOPER=$(df -h | grep '/home$' | awk '{print $5}')

        printf "%s" "$SEP1"
        if [ "$IDENTIFIER" = "unicode" ]; then
                # printf ":%s/%s|:%s/%s:%s" "$MEMUSED" "$MEMTOT" "$STOUSED" "$STOTOT" "$STOPER"
                printf ":%.2f|:%s/%s" "$CPUSED" "$MEMUSED" "$MEMTOT"
        else
                printf "CPU:%.2f|RAM:%s/%s" "$CPUSED" "$MEMUSED" "$MEMTOT"
                # printf "RAM:%s/%s|STO:%s/%s:%s" "$MEMUSED" "$MEMTOT" "$STOUSED" "$STOTOT" "$STOPER"
        fi
        printf "%s\n" "$SEP2"
}

dwm_resources
