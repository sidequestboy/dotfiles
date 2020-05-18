#!/bin/sh

xmodmap "$XDG_CONFIG_HOME/X11/Xmodmap"
pkill xcape
xcape -e "Hyper_R=Tab"
