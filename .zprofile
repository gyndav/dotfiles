#!/usr/bin/env bash

#
# Core
#
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

# coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export EDITOR='nano'

export PAGER='less'

export HOMEBREW_NO_ANALYTICS=1

# Change default ulimit to avoir errors
ulimit -n 1024

#
# Languages
#
export COMPOSER_HOME=${ZDOTDIR:-$HOME}/.composer
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

export GOPATH=/usr/local/Cellar/go
export PATH=$PATH:$GOPATH/bin
