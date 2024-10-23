{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  arc-browser
  # dockutil
  karabiner-elements
  kitty
  obsidian
  slack
  spotify
  zsh-autosuggestions
]
