path=("/opt/homebrew/opt/ruby/bin" $path)
path=("$HOME/.gem/ruby/3.0.0/bin" $path)
path=("$HOME/.cargo/bin" $path)
path=("/opt/homebrew/opt/openjdk/bin" $path)
export PATH

export EDITOR=nvim

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

autoload -U promptinit; promptinit
prompt pure
