# Aliases — ported from .aliases
# abbr for simple shortcuts, alias for command wrappers with arguments

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

alias cat bat
alias ping 'prettyping --nolegend'
alias du 'ncdu --color dark -rr -x'

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
# Docker — alias (not abbr) because of subshells
#
abbr -a dk docker
alias dk-info 'docker info --format "{{json .}}" | jq .'
alias dk-rmc 'docker rm (docker ps -q -f "status=exited")'
alias dk-rmi 'docker rmi (docker images -q -f "dangling=true")'
alias dk-rmv 'docker volume rm (docker volume ls -q -f "dangling=true")'
abbr -a dk-prune 'docker system prune'
abbr -a dcp docker-compose

#
# Useful
#
abbr -a whatsmyip 'curl https://api.ipify.org/'
alias flush-cache 'sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder'
alias flush-terminal 'sudo rm /var/log/asl/*.asl'
alias flush-launchservices '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder'
alias empty-trash "sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv \$HOME/.Trash;"
