#!/usr/bin/env zsh

# slimzsh
if [[ -f "${ZDOTDIR:-$HOME}/.slimzsh/slim.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.slimzsh/slim.zsh"
fi

# zsh completions
fpath=(/usr/local/share/zsh-completions $fpath)

# aliases
if [[ -f "$HOME/.aliases" ]]
then
	source "$HOME/.aliases"
fi

# functions
if [[ -f "$HOME/.functions" ]]
then
	source "$HOME/.functions"
fi

# local, not versionned
if [ -d "$HOME/bin" ]
then
  PATH="$HOME/bin:$PATH"
fi
if [[ -f "$HOME/.localrc" ]]
then
	source "$HOME/.localrc"
fi

# profiles based on local
if [ -f "$HOME/.dotfiles/profiles/${DOTPROFILE:-personal}/init.zsh" ]
then
	source "$HOME/.dotfiles/profiles/${DOTPROFILE:-personal}/init.zsh"
fi

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
