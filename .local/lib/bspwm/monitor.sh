#!/usr/bin/env bash

# MONITORS
autorandr --change

# BACKGROUND
[[ -e "$HOME/.fehbg" ]] && "$HOME/.fehbg"

# BSPWM
for monitor in $(bspc query -M --names); do
    bspc monitor $monitor -d 1 2 3 4 5 6 7
done

# POLYBAR
for monitor in $(polybar --list-monitors | cut -d':' -f1); do
    systemctl --user restart "polybar@$monitor.service"
done

