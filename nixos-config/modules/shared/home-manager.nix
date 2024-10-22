{ config, pkgs, lib, ... }:

let name = "Jamie Macdonald";
    user = "jamie";
    email = "jamie.alban@gmail.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
    ];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      path=("/opt/homebrew/bin" $path)
      path=("$HOME/.local/bin" $path)
      path=("$HOME/.cargo/bin" $path)
      path=("$HOME/.local/share/bin" $path)
      export PATH

      export EDITOR="nvim"
      export FZF_DEFAULT_COMMAND="rg --hidden --files"
      export LC_CTYPE="en_US.UTF-8"
      export LESS="-R --mouse --wheel-lines=3"
      export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
      export TERMINAL="alacritty"
      export NPM_PACKAGES="$HOME/.npm-packages"

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls="ls --color=auto"
      alias l="ls"
      alias la="ls -A"
      alias ll="ls -Al"
      alias sudo="sudo "
      alias cheat="cheat --color"
      alias ch="cheat"
      alias e="$EDITOR"

      bindkey -v
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

      # case insensitive completion
      autoload -Uz compinit && compinit
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
      eval "$(starship init zsh)"
    '';
  };

  git = {
    enable = true;
    ignores = [ "*.swp" ];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "nvim";
        autocrlf = "input";
      };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          # Smart pane switching with awareness of Vim splits.
          # See: https://github.com/christoomey/vim-tmux-navigator
          is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
              | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
          bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
          bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
          bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
          bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
          tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
          if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
              "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'C-h' select-pane -L
          bind-key -T copy-mode-vi 'C-j' select-pane -D
          bind-key -T copy-mode-vi 'C-k' select-pane -U
          bind-key -T copy-mode-vi 'C-l' select-pane -R
          bind-key -T copy-mode-vi 'C-\' select-pane -l
        '';
      }
      tmux-fzf
      sensible
      yank
      prefix-highlight
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
          set -g @resurrect-strategy-nvim 'session'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha' # 'latte' # or frappe, macchiato, mocha

          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text "#W"
          set -g @catppuccin_status_modules_right "directory session"
        '';
      }
    ];
    terminal = "xterm-256color";
    prefix = "C-b";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      # vi copypaste mode
      set-window-option -g mode-keys vi
      if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 4 \)'" 'bind-key -Tcopy-mode-vi v send -X begin-selection; bind-key -Tcopy-mode-vi y send -X copy-selection-and-cancel'
      if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 4\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'bind-key -t vi-copy v begin-selection; bind-key -t vi-copy y copy-selection'

      # neovim and spacemacs wants this
      set-option -g focus-events on
      set-option -sa terminal-overrides ',xterm-256color:RGB'

      # copy to system clipboard
      bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'

      bind - command-prompt -p "paste buffer send to" "paste-buffer -t %%"

      # tmux window numbering
      set -g base-index 1
      set-option -g renumber-windows on

      # status bar on top
      # set-option -g status-position top

      # unintruding status bar colors
      # set -g status-style bg=default
      # set -g status-style fg=default

      # hide status bar when there's only one window.
      set-hook -g window-linked   "set-option -F status '#{?#{==:#{session_windows},1},off,on}'"
      set-hook -g window-unlinked "set-option -F status '#{?#{==:#{session_windows},1},off,on}'"

      # show hostname in status bar
      set -g status-right "#h"

      # set -g default-terminal "screen-256color"
      set -g default-terminal "tmux-256color"

      set -g exit-empty 0


      # Rather than constraining window size to the maximum size of any client 
      # connected to the *session*, constrain window size to the maximum size of any 
      # client connected to *that window*. Much more reasonable.
      setw -g aggressive-resize on

      bind-key M choose-tree -Zw "join-pane -t '%%'"
      bind-key C-m choose-tree -Zs "join-pane -t '%%'"

      # Panes
      # more intuitive split shortcuts
      # split in the direction of the vi key
      bind l split-window -h -c "#{pane_current_path}"
      bind h split-window -hb -c "#{pane_current_path}"
      bind j split-window -v -c "#{pane_current_path}"
      bind k split-window -vb -c "#{pane_current_path}"
      bind C-l split-window -h -c "#{pane_current_path}"
      bind C-h split-window -hb -c "#{pane_current_path}"
      bind C-j split-window -v -c "#{pane_current_path}"
      bind C-k split-window -vb -c "#{pane_current_path}"

      # Windows
      # create in current pane's directory
      bind c new-window -c "#{pane_current_path}"
      bind C-c new-window -c "#{pane_current_path}"
      # create in default ($HOME) directory
      bind C new-window

      # renumber sessions
      set-hook -g session-closed  "run $HOME/.local/lib/tmux/renumber-sessions.sh"
      set-hook -g session-created "run $HOME/.local/lib/tmux/renumber-sessions.sh"

      # scroll 3 lines at a time in copy mode
      bind -Tcopy-mode-vi WheelUpPane send -N3 -X scroll-up
      bind -Tcopy-mode-vi WheelDownPane send -N3 -X scroll-down

      # Watch background windows for activity
      setw -g monitor-activity on
      setw -g activity-action none

      set -s escape-time 0

      # reload config
      bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

      # use mouse
      set -g mouse on


      '';
    };
}
