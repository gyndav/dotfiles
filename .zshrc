#!/usr/bin/env zsh

# pure
fpath=("$HOME/.dotfiles" $fpath)
autoload -Uz promptinit && promptinit
prompt pure

# zsh completions
fpath=("$HOME/.dotfiles/zsh-completions/src" $fpath)
autoload -Uz compinit && compinit

# zsh colors
autoload -Uz colors && colors # Colors

# zsh options
setopt autocd
setopt extendedglob
setopt NO_NOMATCH
unsetopt correct_all # no autocorrect
unsetopt menu_complete # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

if [ -z $HISTFILE ]; then
  HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoredups

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history

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

# zsh syntax highlighting
source "$HOME/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
