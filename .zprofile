#!/usr/bin/env zsh

#
# Core
#
# export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export EDITOR='nano'

export PAGER='less'

export HOMEBREW_NO_ANALYTICS=1

# Change default ulimit to avoir errors
ulimit -n 1024

# GNU
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

export GOPATH="${HOME}/go"

# eliminates duplicates in *paths
typeset -gU cdpath fpath path

# Zsh search path for executable
path=(
	/usr/local/{bin,sbin}
	$path
)
