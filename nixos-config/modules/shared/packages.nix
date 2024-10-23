{ pkgs }:

with pkgs; [
  # General packages for development and system management
  # alacritty
  # aspell
  # aspellDicts.en
  # bash-completion
  # bat
  # btop
  # coreutils
  # killall
  # neofetch
  # openssh
  # sqlite
  starship
  # wget
  # zip

  # Encryption and security tools
  # age
  # age-plugin-yubikey
  # gnupg
  # libfido2

  # Cloud-related tools and SDKs
  # docker
  # docker-compose

  # Media-related packages
  # dejavu_fonts
  # ffmpeg
  # fd
  # font-awesome
  # hack-font
  # noto-fonts
  # noto-fonts-emoji
  # meslo-lgs-nf

  # Node.js development tools
  nodePackages.npm # globally install npm
  nodePackages.prettier
  nodejs
  typescript
  nodePackages.typescript-language-server

  # Text and terminal utilities
  # htop
  # hunspell
  # iftop
  # jetbrains-mono
  gh
  jq
  neovim
  ripgrep
  tree
  tmux
  unrar
  unzip
  # zsh-powerlevel10k

  # Python packages
  python39
  python39Packages.virtualenv # globally install virtualenv
]
