#!/bin/sh
# requires pulsemixer because pactl and pacmd are limited and difficult.
# and I don't mind having a good 3rd party CLI installed

pulsemixer --change-volume +10 --max-volume 100

