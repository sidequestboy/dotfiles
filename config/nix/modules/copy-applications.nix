{ config, lib, pkgs, ... }:

{
  # Import this module in your nix-darin config to have applications copied
  # to /Applications/Nix Apps instead of being symlinked. GUI apps must be
  # added to environment packages, not home-manager for this to work.
  system.activationScripts.applications.text = lib.mkForce ''
    echo "Setting up /Applications/Nix Apps" >&2
    appsSrc="${config.system.build.applications}/Applications/"
    baseDir="/Applications/Nix Apps"
    rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
    mkdir -p "$baseDir"
    ${pkgs.rsync}/bin/rsync $rsyncArgs "$appsSrc" "$baseDir"
  '';
}
