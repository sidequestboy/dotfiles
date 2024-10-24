{ pkgs }:

with pkgs;
let shared-packages = import ../shared/packages.nix { inherit pkgs; }; in
shared-packages ++ [
  arc-browser
  # dockutil
  dbeaver-bin
  gimp
  # karabiner-elements
  kitty
  monitorcontrol
  obsidian
  slack
  spotify
  zsh-autosuggestions
]
