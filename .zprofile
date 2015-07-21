#
# Core
#
PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:/usr/local/sbin:$PATH"

export EDITOR='subl -w'

export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

export EDITOR='subl -w'

export HISTFILE=~/.zsh_history
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL='ignoreboth'
export HISTIGNORE='ls:cd:cd -:pwd:exit:date:* --help'

export PAGER='less'

# Change default ulimit to avoir errors
ulimit -n 1024

#
# PMD
#
export APP_ENV='dev'

#
# Languages
#
export PATH="$(brew --prefix homebrew/php/php56)/bin:$PATH"
export PATH="$(brew --prefix python)/bin:$PATH"
export PATH="$(brew --prefix ruby)/bin:$PATH"

export COMPOSER_HOME=${ZDOTDIR:-$HOME}/.composer
export PATH="$COMPOSER_HOME/vendor/bin:$PATH"

export GOPATH=/usr/local/Cellar/go
export PATH=$PATH:$GOPATH/bin
