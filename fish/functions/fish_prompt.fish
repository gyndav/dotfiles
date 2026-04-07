# Pure prompt — ported from https://github.com/sindresorhus/pure
#
# Layout:
#   [user@host] path git-branch [dirty] [arrows] [duration]
#   ❯
#
# Colors match pure defaults:
#   path=blue  branch=#6c6c6c (grey 242)  dirty=#ffafd7 (pink 218)
#   arrows=cyan  duration=yellow  user@host=#6c6c6c  prompt=magenta  error=red

function fish_prompt
    set -l last_status $status

    set -l preprompt

    # user@host — only on SSH or as root
    if set -q SSH_CONNECTION; or test "$USER" = root
        set -a preprompt (set_color 6c6c6c)$USER"@"$hostname(set_color normal)
    end

    # current directory — blue, full path (no truncation)
    set -g fish_prompt_pwd_dir_length 0
    set -a preprompt (set_color blue)(prompt_pwd)(set_color normal)

    # git info
    if command git rev-parse --is-inside-work-tree &>/dev/null
        set -l branch (command git symbolic-ref --short HEAD 2>/dev/null; or command git describe --tags --exact-match HEAD 2>/dev/null; or command git rev-parse --short HEAD 2>/dev/null)

        set -l git_info (set_color 6c6c6c)$branch(set_color normal)

        # dirty — check for uncommitted or untracked changes
        set -l dirty (command git status --porcelain 2>/dev/null)
        if test -n "$dirty"
            set git_info $git_info(set_color ffafd7)"*"(set_color normal)
        end

        # ahead/behind arrows (single command)
        set -l counts (command git rev-list --left-right --count HEAD...@{upstream} 2>/dev/null | string split \t)
        if test (count $counts) -eq 2
            set -l arrows ""
            if test "$counts[1]" -gt 0
                set arrows "⇡"
            end
            if test "$counts[2]" -gt 0
                set arrows $arrows"⇣"
            end
            if test -n "$arrows"
                set git_info $git_info" "(set_color cyan)$arrows(set_color normal)
            end
        end

        # stash
        if command git rev-parse --verify --quiet refs/stash &>/dev/null
            set git_info $git_info" "(set_color cyan)"≡"(set_color normal)
        end

        set -a preprompt $git_info
    end

    # execution time — show if last command took > 5s
    if test -n "$CMD_DURATION"; and test "$CMD_DURATION" -gt 5000
        set -l secs (math --scale=0 "$CMD_DURATION / 1000")
        set -l human ""

        set -l d (math --scale=0 "$secs / 86400")
        set -l h (math --scale=0 "$secs % 86400 / 3600")
        set -l m (math --scale=0 "$secs % 3600 / 60")
        set -l s (math --scale=0 "$secs % 60")

        test $d -gt 0; and set human {$d}"d "
        test $h -gt 0; and set human $human{$h}"h "
        test $m -gt 0; and set human $human{$m}"m "
        test $s -gt 0; and set human $human{$s}"s"

        set -a preprompt (set_color yellow)$human(set_color normal)
    end

    # blank line before prompt (like pure)
    echo

    # preprompt line
    echo (string join " " $preprompt)

    # prompt character
    if test $last_status -eq 0
        set_color magenta
    else
        set_color red
    end
    echo -n "❯ "
    set_color normal
end
