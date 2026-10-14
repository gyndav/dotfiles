# Aliases — ported from .aliases
# abbr for simple shortcuts, alias for command wrappers with arguments
# Interactive only: never shadow cat/du/cp/… inside `fish -c` or scripts.
status is-interactive; or return

#
# Core
#
abbr -a c clear
abbr -a q exit
abbr -a reload 'exec fish'

alias cp 'cp -i'
alias mv 'mv -i'
alias mkdir 'mkdir -pv'

alias l 'ls -1A --color=auto'
alias ll 'ls -lh --color=auto'
alias la 'ls -lhA --color=auto'

abbr -a .. 'cd ..'

alias grep 'grep --color=auto'

# Only shadow core commands when the replacement is installed
type -q bat; and alias cat bat
type -q prettyping; and alias ping 'prettyping --nolegend'
type -q ncdu; and alias du 'ncdu --color dark -rr -x'

#
# Languages
#
abbr -a rocknroll '$HOME/.dotfiles/bin/rocknroll'

#
# Git
#
abbr -a g git
abbr -a gs 'git status -sb'
abbr -a gd 'git diff --minimal'
abbr -a gpp 'git pull --prune'
abbr -a gca 'git commit --amend --no-edit'

#
# Ruby
#
abbr -a be 'bundle exec'

#
# Docker
#
abbr -a dk docker
alias dk-info 'docker info --format "{{json .}}" | jq .'
abbr -a dk-rmc 'docker container prune'
abbr -a dk-rmi 'docker image prune'
abbr -a dk-rmv 'docker volume prune'
abbr -a dk-prune 'docker system prune'
abbr -a dcp 'docker compose'

#
# Useful
#
abbr -a whatsmyip 'curl https://api.ipify.org/'
alias flush-cache 'sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias flush-launchservices '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
alias empty-trash 'osascript -e \'tell application "Finder" to empty trash\''
