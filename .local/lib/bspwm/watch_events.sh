#!/usr/bin/env bash

while read event; do
    ${HOME}/.local/bin/monitor.sh
done < <(bspc subscribe monitor_add monitor_remove)
