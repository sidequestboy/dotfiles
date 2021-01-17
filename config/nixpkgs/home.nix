{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "jamie";
  home.homeDirectory = "/home/jamie";

  home.packages = [ 
    
    
  ];

  programs.git = {
    enable = true;
    userName = "Jamie Macdonald";
    userEmail = "jamie.alban@gmail.com";
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-nix
    ];
  };

  programs.zsh = {
    enable = true;
    envExtra = ''
      setopt no_global_rcs
    '';
    sessionVariables = {
      BROWSER = "chromium";
      EDITOR = "nvim";
      FZF_DEFAULT_COMMAND = "rg --hidden --files";
      LC_CTYPE = "en_US.UTF-8";
      LESS = "--mouse --wheel-lines=3";
      NVIM_LISTEN_ADDRESS = "/tmp/nvimsocket";
      PATH = "~/.local/bin:$PATH";
      TERMINAL = "alacritty";
    };
    autocd = true;
    localVariables = {
      LS_DEFAULT_ARGS = [ "--color=auto" "-CF" "--group-directories-first" ];
    };
    enableCompletion = true;
    enableAutosuggestions = true;
    shellAliases = {
      ls = "ls $LS_DEFAULT_ARGS";
      l = "ls";
      la = "ls -A";
      ll = "ls -Al";
      sudo = "sudo ";
      cheat = "cheat --color";
      ch = "cheat";
      r = "ranger";
      e = "$EDITOR";
      ss = "sudo systemctl";
      sj = "sudo journalctl -b 0 -e";
      j = "journalctl --user -b 0 -e";
      u = "systemctl --user";
      udr = "systemctl --user daemon-reload";
      us = "systemctl --user status";
      ue = "systemctl --user edit --full";
    };
    initExtra = ''
      bindkey "^P" up-line-or-search
      bindkey "^N" down-line-or-search
      bindkey '^?' backward-delete-char
      bindkey '^A' beginning-of-line
      bindkey '^E' end-of-line
      bindkey '^q' push-line-or-edit

      autoload -U edit-command-line
      zle -N edit-command-line
      bindkey '^V' edit-command-line

      _history-incremental-search-backward () {
        zle .history-incremental-search-backward $BUFFER
      }
      zle -N history-incremental-search-backward _history-incremental-search-backward
      bindkey '^R' history-incremental-search-backward
      bindkey -M isearch '^S' history-incremental-search-forward

      function chpwd() {
        emulate -L zsh
        ls $LS_DEFAULT_ARGS
      }

      # speed up autocomplete when in git repos
      __git_files () {
          _wanted files expl 'local files' _files
      }

      # workaround https://github.com/ohmyzsh/ohmyzsh/issues/8751
      _systemctl_unit_state() {
        typeset -gA _sys_unit_state
        _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') ) }

    zstyle :prompt:pure:git:stash show yes
    '';
    defaultKeymap = "viins";
    zplug.enable = true;
    zplug.plugins = [
      { name = "zsh-users/zsh-syntax-highlighting"; }
      { name = "zsh-users/zsh-autosuggestions"; }
      { name = "wfxr/forgit"; tags = [ "defer:1" ]; }
      { name = "mafredri/zsh-async"; tags = [ "from:github" ]; }
      { name = "sindresorhus/pure";
        tags = [ "use:pure.zsh" "from:github" "as:theme" ]; }
      { name = "plugins/git"; tags = [ "from:oh-my-zsh" ]; }
      { name = "lib/history"; tags = [ "from:oh-my-zsh" ]; }
    ];
  };

  services.syncthing = {
    enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
