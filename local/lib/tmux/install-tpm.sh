#!/bin/sh
install_dir="$HOME/.tmux/plugins"

if [ ! -d "$install_dir" ]
then
	mkdir -p "$install_dir"
fi

if [ ! -d "$install_dir"/tpm ]
then
	git clone https://github.com/tmux-plugins/tpm "$install_dir"/tpm
fi
