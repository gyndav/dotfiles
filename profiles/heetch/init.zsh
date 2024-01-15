#!/usr/bin/env zsh

export HEETCH_DIR="${HOME}/go/src/github.com/heetch"

function heetch() {
  cd $HEETCH_DIR
}

# yarn global
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Golang
export GOPROXY="https://proxy.golang.org,direct"
export GONOPROXY="github.com/heetch"
export GONOSUMDB="github.com/heetch"
export GOPRIVATE="github.com/heetch"

# keg-only
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/openssl@1.1/bin:$PATH"
export PATH="/opt/homebrew/opt/ssh-copy-id/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

export PATH="$HOME/.docker/bin:$PATH"

alias unibe='uni exec bundle exec --'

HTTPSTAT_SAVE_BODY="false"

# ENGINE_BOOT=api uni exec -- bundle exec rails server

# alias ux='uni exec --'
# alias utx='uni exec --env=test --'

# alias ubxc='uni exec bundle exec rails console --'
# alias utbx='uni exec --env=test bundle exec --'
