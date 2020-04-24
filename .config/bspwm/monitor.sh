#!/bin/sh

autorandr --change
systemctl --user stop 'polybar@*.service'
for monitor in $(bspc query -M --names); do
    bspc monitor $monitor -d 1 2 3 4 5 6 7
    systemctl --user start "polybar@$monitor.service"
done
