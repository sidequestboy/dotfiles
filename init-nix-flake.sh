#!/usr/bin/env bash

nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake $(readlink ~/.config/nix)#meteorite


