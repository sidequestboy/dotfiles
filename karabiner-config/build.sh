#!/usr/bin/env bash

mkdir "${HOME}/.config/karabiner"

tsc src/index.ts && node src/index.js
