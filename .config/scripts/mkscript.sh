#!/bin/bash

contents="#!/bin/bash"

for i in $@; do
        echo -e "$contents\n" > $i
        chmod 755 $i
done
