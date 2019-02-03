#!/usr/bin/env bash

#
# Core
#
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export EDITOR='nano'

export PAGER='less'

export HOMEBREW_NO_ANALYTICS=1

# Change default ulimit to avoir errors
ulimit -n 1024

# GNU
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export PATH="$(brew --prefix make)/libexec/gnubin:$PATH"

export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

#
# Languages
#
export COMPOSER_HOME=${ZDOTDIR:-$HOME}/.composer
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

export PATH=$PATH:/usr/local/opt/go/libexec/bin:$HOME/go/bin

export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

export GOPATH="${HOME}/go"
