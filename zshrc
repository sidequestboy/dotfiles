path=("/opt/homebrew/bin" $path)
path=("$HOME/.local/bin" $path)
path=("$HOME/.cargo/bin" $path)
export PATH

#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#	exec tmux attach
#fi

export EDITOR="nvim"
export BROWSER="chromium"
export EDITOR="nvim"
export FZF_DEFAULT_COMMAND="rg --hidden --files"
export LC_CTYPE="en_US.UTF-8"
export LESS="-R --mouse --wheel-lines=3"
export NVIM_LISTEN_ADDRESS="/tmp/nvimsocket"
export TERMINAL="alacritty"
export NPM_PACKAGES="$HOME/.npm-packages"

if [[ -e "$HOME/.secrets.zsh" ]]; then
  source "$HOME/.secrets.zsh"
fi

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

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
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

