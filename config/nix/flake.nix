{
  description = "sidequestboy's darwin flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, lib, ... }: {

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
	  pkgs.tmux
	  pkgs.kitty
	  pkgs.obsidian
	  pkgs.slack
	  pkgs.starship
        ];

      homebrew = {
        enable = true;
	brews = [
	  "mas"
	  "zsh-syntax-highlighting"
	  "zsh-autosuggestions"
	];
	casks = [
	  "firefox"
	  "bitwarden"
	  "nordvpn"
	  "whatsapp"
	  "todoist"
	];
	masApps = {
	  "System Color Picker" = 1545870783;
	};
	onActivation = {
	  upgrade = true;
	  cleanup = "zap";
	};
      };

      system.activationScripts.applications.text = lib.mkForce ''
	echo "Setting up /Applications/Nix Apps" >&2
	appsSrc="${config.system.build.applications}/Applications/"
	baseDir="/Applications/Nix Apps"
	rsyncArgs="--archive --checksum --chmod=-w --copy-unsafe-links --delete"
	mkdir -p "$baseDir"
	${pkgs.rsync}/bin/rsync $rsyncArgs "$appsSrc" "$baseDir"
      '';

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh.enable = true;  # default shell on catalina
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."meteorite" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
	nix-homebrew.darwinModules.nix-homebrew
	{
	  nix-homebrew = {
	    enable = true;
	    enableRosetta = true;
	    user = "jamie";
	  };
	}
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."meteorite".pkgs;
  };
}
