path=("$HOME/.local/bin" $path)
path=("$HOME/.cargo/bin" $path)
path=("$HOME/.gem/ruby/3.1.0/bin" $path)
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
export CC="gcc-12"

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

# pure prompt
if [[ ! -d "$HOME/.zsh" ]]
then
  mkdir -p "$HOME/.zsh"
fi
if [[ ! -d "$HOME/.zsh/pure" ]]
then
  git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
fi

fpath+=$HOME/.zsh/pure

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

autoload -U promptinit; promptinit
prompt pure
