# fish config — ported from .zprofile + .zshrc

#
# Environment
#
set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'

set -gx EDITOR 'nano'
set -gx PAGER 'less'

# Don't clear the screen after quitting a manual page
set -gx MANPAGER 'less -X'

set -gx HOMEBREW_NO_ANALYTICS 1

# Needed to prevent GPG issues
set -gx GPG_TTY (tty)

#
# PATH
#
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path /usr/local/opt/coreutils/libexec/gnubin
fish_add_path /usr/local/opt/make/libexec/gnubin
fish_add_path $HOME/.local/bin

# mise — shims-in-PATH approach
fish_add_path $HOME/.local/share/mise/shims

# Change default ulimit
ulimit -n 1024

#
# Google Cloud SDK
#
if test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc
    source /opt/homebrew/share/google-cloud-sdk/path.fish.inc
end

#
# fzf
#
if type -q fzf
    fzf --fish | source
end

#
# Local config (not versioned)
#
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
