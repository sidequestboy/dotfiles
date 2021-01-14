#!/bin/sh
# vim build script

filename="$1"

log() {
	echo $@ 1>&2
}

if echo "$filename" | grep -q -E '^.*sxhkdrc$'; then
	log "Reloading sxhkd..."
	systemctl --user reload sxhkd
	exit $?
fi

