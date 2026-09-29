# fish config — ported from .zprofile + .zshrc

#
# Environment
#
set -gx LANG 'en_US.UTF-8'
set -gx LC_ALL 'en_US.UTF-8'

set -gx EDITOR nano
set -gx PAGER less

# Don't clear the screen after quitting a manual page
set -gx MANPAGER 'less -X'

set -gx HOMEBREW_NO_ANALYTICS 1

#
# PATH — rebuilt from this file on every start, never persisted.
# Installers love `fish_add_path` (universal), which silently piles up stale
# entries; drop that and keep fish_user_paths global so this file is the
# single source of truth (~/.localrc.fish additions stay global too).
#
set -qU fish_user_paths; and set -eU fish_user_paths
set -g fish_user_paths

# Highest priority first. /usr/local/bin stays ahead of Homebrew for GPG Suite's gpg.
fish_add_path --global --move \
    $HOME/.local/share/mise/shims \
    $HOME/.local/bin \
    $HOME/.cargo/bin \
    $HOME/.maestro/bin \
    $HOME/.grok/bin \
    /usr/local/bin \
    /opt/homebrew/bin \
    /opt/homebrew/sbin

# Lowest priority: global installs that must not shadow mise/Homebrew
fish_add_path --global --append $HOME/.bun/bin $HOME/.docker/bin

# Keg-only libpq (psql, pg_dump…) — kept off /opt/homebrew/bin so a full
# postgresql@* formula never conflicts with it
fish_add_path --global --append /opt/homebrew/opt/libpq/bin

# Change default ulimit
set -l hard_limit (ulimit -Hn)
if test "$hard_limit" = unlimited; or test "$hard_limit" -ge 65536
    ulimit -n 65536
end

#
# Google Cloud SDK
#
if test -f /opt/homebrew/share/google-cloud-sdk/path.fish.inc
    source /opt/homebrew/share/google-cloud-sdk/path.fish.inc
end

#
# Interactive only
#
if status is-interactive
    # Needed to prevent GPG issues
    set -gx GPG_TTY (tty)

    type -q fzf; and fzf --fish | source
end

#
# Local config (not versioned)
#
if test -f ~/.localrc.fish
    source ~/.localrc.fish
end
