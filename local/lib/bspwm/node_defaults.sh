#!/bin/bash
# Prints desktop, state, layer rules defined by `bspc rule -l`
# for focused window or provided node id and formatted for
# `bspc node` commands
# e.g. `bspc node -m any.!focused $(node_defaults.sh)`

node_sel="$1"
[ -z "$node_sel" ] && node_sel=$(bspc query -N focused -n)

xprop_output=$(xprop -id "$node_sel" | grep WM_CLASS)
node_instance=$(echo "$xprop_output" | awk -F '"' '{ print $2 }')
node_class=$(   echo "$xprop_output" | awk -F '"' '{ print $4 }')

rules=$(bspc rule -l)

rules_1=$(echo "$rules" | grep "^$node_class:$node_instance " | awk -F '=> ' '{ print $2 }')
rules_2=$(echo "$rules" | grep "^\*:$node_instance "          | awk -F '=> ' '{ print $2 }')
rules_3=$(echo "$rules" | grep "^$node_class:\* "             | awk -F '=> ' '{ print $2 }')
rules_4=$(echo "$rules" | grep "^\*:\* "                      | awk -F '=> ' '{ print $2 }')

rules="$rules_1\n$rules_2\n$rules_3\n$rules_4"

desktop=$(echo "$rules" | grep -o -P 'desktop=\S+' | head -n1 | cut -d'=' -f2)
state=$(  echo "$rules" | grep -o -P 'state=\S+'   | head -n1 | cut -d'=' -f2)
layer=$(  echo "$rules" | grep -o -P 'layer=\S+'   | head -n1 | cut -d'=' -f2)

options=''

[ -n "$desktop" ] && options="$options -d $desktop --follow"
[ -n "$state"   ] && options="$options -t $state"
[ -n "$layer"   ] && options="$options -l $layer"

echo "$options"
