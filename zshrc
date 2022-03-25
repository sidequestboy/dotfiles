export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/3.0.0/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.nix-profile/bin:$PATH"

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
