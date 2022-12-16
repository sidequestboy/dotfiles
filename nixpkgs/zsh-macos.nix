{
  programs.zsh = {
    enable = true;
    sessionVariables = {
      EDITOR = "nvim";
    };
    autocd = true;
    localVariables = {
      NPM_PACKAGES = "$HOME/.npm-packages";
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
    };
    initExtra = ''
      path=("$HOME/.local/bin" $path)
      path=("$HOME/.emacs.d/bin" $path)
      path=("/opt/homebrew/bin" $path)
      path=("/opt/homebrew/opt/openjdk/bin" $path)
      path=("$HOME/.cargo/bin" $path)
      path=("$HOME/.gem/ruby/3.0.0/bin" $path)
      path=("/opt/homebrew/opt/ruby/bin" $path)
      export PATH

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
}
