#!/usr/bin/env bash

npm install

mkdir "${HOME}/.config/karabiner"

tsc src/index.ts && node src/index.js
