path=("/usr/local/bin" $path)
path=("/opt/homebrew/opt/openjdk/bin" $path)
path=("/opt/homebrew/opt/ruby/bin" $path)
path=("/opt/homebrew/bin" $path)
path=("./node_modules/.bin" $path)
path=("/Applications/Docker.app/Contents/Resources/bin/" $path)
path=("$HOME/.local/bin" $path)
path=("$HOME/.gem/ruby/3.1.0/bin" $path)
path=("$HOME/.luarocks/bin" $path)
path=("$HOME/.emacs.d/bin" $path)
path=("$HOME/.cargo/bin" $path)
path=("$HOME/my/code/projects/scale-tray/llvm-project/build/bin" $path)
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

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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

