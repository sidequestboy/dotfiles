#!/bin/sh

set -m

xidlehook \
    --timer 10 'xset dpms force off' 'xset -dpms' \
    --timer 5 'systemctl hybrid-sleep' 'xset -dpms' &
pid=$!

betterlockscreen -l dim
kill $pid

