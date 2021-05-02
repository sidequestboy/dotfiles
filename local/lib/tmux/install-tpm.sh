#!/bin/sh
install_dir="$HOME/.tmux/plugins"

if [ ! -d "$install_dir" ]
then
	mkdir -p "$install_dir"
	git clone https://github.com/tmux-plugins/tpm "$install_dir"/tpm
fi
