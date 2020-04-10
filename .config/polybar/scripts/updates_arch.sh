#!/bin/sh

cachedir="$XDG_CACHE_HOME/polybar"
! [ -d "$cachedir" ] && mkdir -p "$cachedir"

while :
do
    list_updates=$(checkupdates 2> /dev/null)
    if [ "$?" -ne 0 ]; then
        # no connection - read from cache
        cat "$cachedir/updates_arch" 2> /dev/null
        if [ "$?" -eq 0 ]; then
            sleep 5
            exit 0
        else
            # no cache - exit
            echo " ?, ?" && sleep 5 && exit 1
        fi
    fi

    if ! updates_arch=$(echo "$list_updates" | wc -l ); then
        updates_arch=0
    fi

    if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
        updates_aur=0
    fi

    updates=$(("$updates_arch" + "$updates_aur"))
    if [ "$updates" -gt 0 ]; then
        echo -e "  $updates_arch, $updates_aur"
        echo -e "  $updates_arch, $updates_aur" > "$cachedir/updates_arch"
    else
        echo -e "  No Updates"
    fi
    sleep 300
done
