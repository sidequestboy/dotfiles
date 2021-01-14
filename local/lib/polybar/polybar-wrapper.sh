#! /usr/bin/env bash

if ! systemctl --user --quiet is-active spotify-listener; then
    systemctl --user start spotify-listener.service
fi

if [ "$MONITOR" = "eDP1" ] && [ "${BASH_ARGV[0]}" = "top" ]; then
    polybar -c <(cat "$XDG_CONFIG_HOME/polybar/config" "$XDG_CONFIG_HOME/polybar/systray.ini") $@
else
    polybar $@
fi

if [ -z "$(systemctl --user list-units 'polybar@*' --no-legend --plain)" ]; then
    systemctl --user stop spotify-listener.service
fi
