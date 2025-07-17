#!/usr/bin/env bash

nix run .#build-switch
sudo ./result/sw/bin/darwin-rebuild switch --flake .#aa
rch64-darwin
