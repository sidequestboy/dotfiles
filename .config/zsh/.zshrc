# set up command history
HISTSIZE=10000
SAVEHIST=10000

# enable autocomplete
autoload -Uz compinit; compinit

# initialize the prompt system
autoload -U promptinit; promptinit

# vim keys n stuff
bindkey -v
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^P' up-history
bindkey '^N' down-history

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_TMUX=1
export FZF_CTRL_T_COMMAND='rg --files --hidden --no-ignore-vcs'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_ALT_C_OPTS="--select-1 --exit-0 --preview 'tree -C {} | head -200'"

# locale
export LC_CTYPE="en_US.UTF-8"

# share history between terminals
setopt share_history

export BROWSER='chromium'
export EDITOR='nvim'
export PATH=~/.config/tmuxifier/bin:~/git/doom-emacs/bin:~/.local/bin:$PATH

export KANBANFILE='~/.kanban.csv'

eval "$(tmuxifier init -)"

# aliases
# default options
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"
alias ls="sed 's/^/-I \"/; s/$/\"/' .hidden 2>/dev/null | tr '\n' ' ' | xargs ls --color=auto"
alias lsa="command ls -a --color=auto"
#alias man='man -Helinks'
alias vtop='vtop --theme wal'
alias scrot_full="scrot '%Y-%m-%d_$wx$h_scrot.png' -e 'mv $f ~/pics/screenshots'"
alias cp="rsync -avzz --progress"
alias startx="startx $XDG_CONFIG_HOME/X11/xinitrc"

# program shortcuts
alias r="ranger"
alias e="$EDITOR"
alias chat="weechat"
alias prm=". $HOME/.local/bin/prm.sh"
alias tm="tmuxifier"

# systemd
alias ss="sudo systemctl"
alias sjctl="sudo journalctl"
alias uctl="systemctl --user"
alias udr="systemctl --user daemon-reload"

# task shortcuts
alias vw="$EDITOR ~/vimwiki/index.wiki"
alias t="taskell ~/sync/taskell.md"

alias ssh='TERM=xterm ssh'

# ls after each cd
function chpwd() {
    emulate -L zsh
    ls
#    if [ -n $(git remote -v | rg 'jameh/dotfiles') ]; then
#        export PURE_GIT_UNTRACKED_DIRTY=0
#    else
#        export PURE_GIT_UNTRACKED_DIRTY=1
#    fi
}

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
zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zstyle :prompt:pure:git:stash show yes

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load

# vim: set expandtab ts=4 sw=4:
