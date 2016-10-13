# slimzsh
if [[ -f "${ZDOTDIR:-$HOME}/.slimzsh/slim.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.slimzsh/slim.zsh"
fi

# zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# functions
[[ -f ~/.functions ]] && source ~/.functions

# Bin
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

export PATH="$HOME/.yarn/bin:$PATH"
