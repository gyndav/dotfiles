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

# keg-only
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

export PATH="/usr/local/opt/libxslt/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libxslt/lib"
export CPPFLAGS="-I/usr/local/opt/libxslt/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxslt/lib/pkgconfig"

export PATH="/usr/local/opt/curl/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/curl/lib"
export CPPFLAGS="-I/usr/local/opt/curl/include"
export PKG_CONFIG_PATH="/usr/local/opt/curl/lib/pkgconfig"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export PATH="/usr/local/opt/protobuf@3.1/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

alias unibe='uni exec bundle exec --'

HTTPSTAT_SAVE_BODY="false"

# ENGINE_BOOT=api uni exec -- bundle exec rails server

# alias ux='uni exec --'
# alias utx='uni exec --env=test --'

# alias ubxc='uni exec bundle exec rails console --'
# alias utbx='uni exec --env=test bundle exec --'
