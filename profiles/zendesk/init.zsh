#!/usr/bin/env zsh

#
# exports
#
export BIMEIO=~/dev/bimeio
export EXPLORE=~/Code/zendesk/zendesk-explore
export EXPLORE_RAILS_DIR=~/Code/zendesk/explore_rails
export EXPLORE_WALMART_DIR=~/Code/zendesk/explore_walmart

export _JAVA_OPTIONS='-Xms512m -Xmx3g -Xss10m -Duser.language=en -Duser.country=US -Duser.timezone=UTC'

# rbenv
eval "$(rbenv init -)"

# gcloud
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc

# keg-only Node.js
export PATH="/usr/local/opt/node@8/bin:$PATH"

# keg-only Python 2
export PATH="/usr/local/opt/python@2/libexec/bin:$PATH"
