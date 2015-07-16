# slimzsh
if [[ -f "${ZDOTDIR:-$HOME}/.slimzsh/slim.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.slimzsh/slim.zsh"
fi

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Bin
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi
