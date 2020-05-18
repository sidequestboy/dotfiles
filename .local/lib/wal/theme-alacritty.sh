#!/bin/sh

alacritty_conf="$HOME/.config/alacritty/alacritty.yml"
alacritty_wal="$HOME/.cache/wal/alacritty.yml"

color_start=$(grep -n 'color_start' "$alacritty_conf" | cut -d ':' -f1)
color_end=$(grep -n 'color_end' "$alacritty_conf" | cut -d ':' -f1)

echo "$color_start"
echo "$color_end"

if [ -z "$color_start" ]; then
	echo Found no \# color_start line in "$alacritty_conf"
	echo Please add one.
	exit 1
fi

if [ -z "$color_end" ]; then
	echo Found no \# color_end line in "$alacritty_conf"
	echo Please add one.
	exit 1
fi

tmpfile=$(mktemp)

head -n "$color_start" "$alacritty_conf" > "$tmpfile"
cat "$alacritty_wal" >> "$tmpfile"
tail -n +"$color_end" "$alacritty_conf" >> "$tmpfile"
cp "$tmpfile" "$alacritty_conf"
rm "$tmpfile"
