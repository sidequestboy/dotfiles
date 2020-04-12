#!/bin/sh

echo "  ?, ?"

_checkupdates() {
    echo " $(pacman -Qu | wc -l), $(yay -Qum | wc -l)"
}

trap _checkupdates SIGUSR1
_checkupdates

inotifywait -e close_write,moved_to,create -q -m --exclude '.*\.part' \
            --format %e /var/lib/pacman/sync |
while read -r event; do
    while pgrep pacman 2> /dev/null; do
        sleep 1
    done
    _checkupdates
done

