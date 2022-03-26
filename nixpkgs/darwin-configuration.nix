{ config, pkgs, ... }:

{
  imports = [ <home-manager/nix-darwin> ];

  users.users.jamie = {
    name = "jamie";
    home = "/Users/jamie";
  };

  environment.systemPackages = with pkgs; [
    tmux
    vim
    neovim
    coreutils
    findutils
    gnugrep
    gnused
    ripgrep
    nodejs
  ];

  home-manager.users.jamie = { pkgs, ... }: {
    imports = [
      ./git.nix
      ./nvim.nix
      ./zsh.nix
    ];
  };

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
