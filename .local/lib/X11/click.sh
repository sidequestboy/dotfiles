#! /bin/sh

b="$(echo "$@" | cut -d' ' -f1)"
n="$(echo "$@" | cut -d' ' -f2)"

for i in $(seq "$n"); do
    echo scroll
    xdotool click --window "$(xqp)" "$b"
done
