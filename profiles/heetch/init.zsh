#!/usr/bin/env zsh

export HEETCH_DIR="${HOME}/go/src/github.com/heetch"

function heetch() {
  cd $HEETCH_DIR
}

function customer-care_run-deps() {
  gravity run -n legacy-coupon,product,city,coupon,driver-state
}

# yarn global
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Golang
export GOPROXY="https://proxy.golang.org,direct"
export GONOPROXY="github.com/heetch"
export GONOSUMDB="github.com/heetch"
export GOPRIVATE="github.com/heetch"

# keg-only
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/usr/local/opt/libxslt/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/protobuf@3.1/bin:$PATH"
export PATH="/usr/local/opt/postgresql@11/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"

alias unibe='uni exec bundle exec --'

HTTPSTAT_SAVE_BODY="false"

# ENGINE_BOOT=api uni exec -- bundle exec rails server

# alias ux='uni exec --'
# alias utx='uni exec --env=test --'

# alias ubxc='uni exec bundle exec rails console --'
# alias utbx='uni exec --env=test bundle exec --'
