# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && . "$HOME/.fig/shell/zshrc.pre.zsh"
#!/usr/bin/env zsh

# zmodload zsh/zprof

# shell
fpath+=/usr/local/share/zsh/site-functions
fpath+="$HOME/.dotfiles/zsh-completions/src"

autoload -Uz compinit

if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit;
else
  compinit -C;
fi;

# zsh colors
autoload -Uz colors; colors # Colors

# prompt
fpath+=$HOME/.dotfiles/pure
autoload -Uz promptinit; promptinit
prompt pure

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

# various sourcing
source $(brew --prefix asdf)/libexec/asdf.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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

# local, not versioned
if [[ -f "$HOME/.localrc" ]]
then
  source "$HOME/.localrc"
fi

# profiles based on local
if [[ -f "$HOME/.dotfiles/profiles/${DOTPROFILE:-personal}/init.zsh" ]]
then
  source "$HOME/.dotfiles/profiles/${DOTPROFILE:-personal}/init.zsh"
fi

# https://github.com/zsh-users/zsh-syntax-highlighting#why-must-zsh-syntax-highlightingzsh-be-sourced-at-the-end-of-the-zshrc-file
source "$HOME/.dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && . "$HOME/.fig/shell/zshrc.post.zsh"
export PATH="/opt/homebrew/opt/libxml2/bin:$PATH"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/davidg/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
