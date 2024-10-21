{
	description = "sidequestboy's darwin flake";

	inputs = {
		# nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
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
         environment.systemPackages = with pkgs;
         [ neovim
           tmux
           kitty
           obsidian
           slack
           starship
           arc-browser
           nodejs
           typescript
           karabiner-elements
         ];

      homebrew = {
        enable = true;
	brews = [
	  "mas"
	  "zsh-autosuggestions"
	  # "node@20"
	];
	casks = [
	  "firefox"
	  "bitwarden"
	  "nordvpn"
	  "whatsapp"
	  "todoist"
    #"karabiner-elements"
	];
	masApps = {
	  "System Color Picker" = 1545870783;
	};
	onActivation = {
	  autoUpdate = true;
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

      networking.computerName = "meteorite";
      networking.hostName = "meteorite";
      networking.localHostName = "meteorite";

      nix.settings.auto-optimise-store = true;

      programs.nix-index.enable = true;
      programs.zsh = {
        enableFzfHistory = true;
	enableFzfCompletion = true;
	enableSyntaxHighlighting = true;
      };

      environment.darwinConfig = "$HOME/.config/nix/flake.nix";

      system.defaults = {
        dock.autohide = true;
	dock.persistent-apps = [
	  "${pkgs.kitty}/Applications/Kitty.app"
	  "${pkgs.obsidian}/Applications/Obsidian.app"
	  "/System/Applications/Calendar.app"
	];
	dock.appswitcher-all-displays = true;
	dock.autohide-delay = 0.0;
	dock.orientation = "left";
	finder.FXPreferredViewStyle = "clmv";
	finder.ShowPathbar = true;
	finder.ShowStatusBar = true;
	finder.AppleShowAllFiles = true;
	finder.AppleShowAllExtensions = true;
	loginwindow.GuestEnabled = false;
	NSGlobalDomain.AppleInterfaceStyle = "Dark";
	NSGlobalDomain.KeyRepeat = 2;
	NSGlobalDomain.AppleShowAllFiles = true;
      };

      services.karabiner-elements.enable = true;

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

# vim: ts=2:sw=2:expandtab
