export PYENV_ROOT="$HOME/.pyenv"
command -v /opt/homebrew/bin/pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(/opt/homebrew/bin/pyenv init -)"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"
