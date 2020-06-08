# set up command history
# HISTSIZE=10000
# SAVEHIST=10000

# enable autocomplete
autoload -Uz compinit; compinit

# initialize the prompt system
autoload -U promptinit; promptinit

# vim keys n stuff
#bindkey -v
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
#bindkey '^R' history-incremental-search-backward
bindkey -M isearch '^S' history-incremental-search-forward
# locale
export LC_CTYPE="en_US.UTF-8"

export LESS='--mouse --wheel-lines=3'

# share history between terminals
setopt share_history

export BROWSER='chromium'
export PATH=~/.gem/ruby/2.7.0/bin:~/.local/bin:$PATH
export EDITOR='nvim'
export TERMINAL='alacritty'
export NVIM_LISTEN_ADDRESS='/tmp/nvimsocket'

export KANBANFILE='~/.kanban.csv'
export FZF_DEFAULT_COMMAND='rg --hidden --files'

setopt auto_cd

# aliases
alias sudo='sudo '
# default options
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias ls="sed 's/^/-I \"/; s/$/\"/' .hidden 2>/dev/null | tr '\n' ' ' | xargs ls --color=auto -CF --group-directories-first"
alias l="ls"
alias la="ls -A"
alias ll="ls -Al"
alias lsa="command ls -A --color=auto"
#alias man='man -Helinks'
alias vtop='vtop --theme wal'
alias scrot_full="scrot '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f ~/pics/screenshots'"
alias cp="rsync -avzz --progress"
alias startx="startx $XDG_CONFIG_HOME/X11/xinitrc"
alias gs="git status"
alias cheat="cheat --color"
alias ch=cheat
alias e="$EDITOR"

# program shortcuts
alias r="ranger"
alias e="edit.sh"
alias v="$EDITOR"
alias chat="weechat"
alias prm=". $HOME/.local/bin/prm.sh"

# systemd
alias ss="sudo systemctl"
alias sjctl="sudo journalctl"
alias u="systemctl --user"
alias udr="systemctl --user daemon-reload"
alias us="systemctl --user status"
alias ue="systemctl --user edit --full"
alias j="journalctl --user -b 0 -e"
alias sj="sudo journalctl -b 0 -e"

# task shortcuts
alias vw="$EDITOR ~/docs/vimwiki/index.wiki"
alias t="taskell ~/sync/taskell.md"

alias ssh='TERM=xterm ssh'

# ls after each cd
function chpwd() {
    emulate -L zsh
    ls
}

# speed up autocomplete when in git repos
__git_files () {
    _wanted files expl 'local files' _files
}

# workaround https://github.com/ohmyzsh/ohmyzsh/issues/8751
_systemctl_unit_state() {
  typeset -gA _sys_unit_state
  _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') ) }

# plugins
# check if zplug is installed
if [[ ! -d "$ZPLUG_HOME" ]]; then
    git clone https://github.com/zplug/zplug "$ZPLUG_HOME"
    source "$ZPLUG_HOME"/init.zsh && zplug update --self
fi

source "$ZPLUG_HOME"/init.zsh

# interactive git commands
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "wfxr/forgit", defer:1
#zplug "themes/robbyrussell", from:oh-my-zsh, as:theme
zplug "mafredri/zsh-async", from:github
zplug "jameh/pure", use:pure.zsh, from:github, as:theme
zplug "plugins/git", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh

zstyle :prompt:pure:git:stash show yes

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# vim: set expandtab ts=4 sw=4:
