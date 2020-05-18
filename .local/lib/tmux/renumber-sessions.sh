#!/usr/bin/env bash

sessions=$(tmux ls | grep '^[0-9]\+.*:' | cut -f1 -d':' | sort -g)

new=1
for old in $sessions
do
  tmux rename -t $old $new$(printf '%s' "$old" | sed 's/^[0-9]*//')
  ((new++))
done
