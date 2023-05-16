path=("/Applications/Docker.app/Contents/Resources/bin/" $path)
path=("$HOME/.local/bin" $path)
path=("$HOME/.cargo/bin" $path)
path=("$HOME/.gem/ruby/3.1.0/bin" $path)
path=("$HOME/.emacs.d/bin" $path)
path=("/usr/local/bin" $path)
path=("/opt/homebrew/opt/openjdk/bin" $path)
path=("/opt/homebrew/opt/ruby/bin" $path)
path=("/opt/homebrew/bin" $path)
export PATH

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
	exec tmux
fi

export EDITOR="nvim"
export BROWSER="chromium"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="rg --hidden --files"
export LC_CTYPE="en_US.UTF-8"
export LESS="-R --mouse --wheel-lines=3"
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
export TERMINAL="alacritty"
export NPM_PACKAGES="$HOME/.npm-packages"
#export CC="gcc-12"

alias ls="ls --color=auto"
alias l="ls"
alias la="ls -A"
alias ll="ls -Al"
alias sudo="sudo "
alias cheat="cheat --color"
alias ch="cheat"
alias r="ranger"
alias e="$EDITOR"
alias ss="sudo systemctl"
alias sj="sudo journalctl -b 0 -e"
alias j="journalctl --user -b 0 -e"
alias u="systemctl --user"
alias udr="systemctl --user daemon-reload"
alias us="systemctl --user status"
alias ue="systemctl --user edit --full"

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
eval "$(starship init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/jamie/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/jamie/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/jamie/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/jamie/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

