#!/usr/bin/env zsh

export HEETCH_DIR="${HOME}/go/src/github.com/heetch"

function heetch() {
  cd $HEETCH_DIR
}

function launch_admin_deps() {
  gravity run -n legacy-coupon,product,city,coupon,driver-state
}

# keg-only
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"
export PKG_CONFIG_PATH="/usr/local/opt/libxml2/lib/pkgconfig"

export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

export PATH="/usr/local/opt/protobuf@3.1/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/readline/lib"
export CPPFLAGS="-I/usr/local/opt/readline/include"
