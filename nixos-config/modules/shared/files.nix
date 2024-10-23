{ user, pkgs, config, lib, ... }:

let
 home = config.users.users.${user}.home;
 xdg_configHome = "${config.users.users.${user}.home}/.config";
in
{
  # "${xdg_configHome}/nvim" = {
  #   text = builtins.readFile ./config/nvim;
  # };

  # "${xdg_configHome}/nvim" = {
  #   source = lib.file.mkOutOfStoreSymlink ${home}/dots/config/nvim;
  #   target = "nvim";
  # };
  # ...

}
