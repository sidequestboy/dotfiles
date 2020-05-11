#!/bin/sh
xidlehook \
    --timer 30  'xset dpms force off' 'xset -dpms' \
    --timer 300 'systemctl suspend'   '' &
pid=$!
betterlockscreen -l dim
kill $pid

