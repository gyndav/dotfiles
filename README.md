# dotfiles

macOS development environment. One command to bootstrap a new machine — Fish shell, 100+ Homebrew packages, opinionated Git, and sane macOS defaults.

[![License](https://img.shields.io/github/license/gyndav/dotfiles)](LICENSE)
[![macOS](https://img.shields.io/badge/macOS-Sequoia-000000?logo=apple&logoColor=white)](bin/osx)
[![Fish](https://img.shields.io/badge/shell-fish-34C534)](fish/)
[![Homebrew](https://img.shields.io/badge/homebrew-100%2B_packages-FBB040?logo=homebrew)](Brewfile)

---

- **Fish shell** — Pure-inspired prompt, smart aliases, modern CLI replacements (`bat`, `fd`, `fzf`, `prettyping`, `ncdu`)
- **Git** — 36 aliases, GPG signing, difftastic diffs, performance tuning (fsmonitor, protocol v2, rerere)
- **Homebrew** — 85+ formulae + 30+ casks declared in a `Brewfile`: dev tools, cloud/infra CLIs, editors, fonts, security, AI/LLM tooling
- **macOS defaults** — trackpad, keyboard, Finder, Safari, UI preferences, and a raised open-files limit
- **Languages** — Node 24, Ruby 3.4, Go 1.27, Python 3.14, Java 17, uv, Bun via mise
- **Mac migration** — full backup/restore script for moving to a new machine

## Setup

Clone and run the bootstrap:

```sh
git clone https://github.com/gyndav/dotfiles.git ~/.dotfiles
~/.dotfiles/bin/rocknroll
```

`rocknroll` installs Homebrew (if missing), everything in the `Brewfile`, symlinks dotfiles (backing up any real file in the way), installs the git hooks, and sets Fish as the default shell. It is safe to re-run.

Apply opinionated macOS preferences and install the open-files limit LaunchDaemon (`limit.maxfiles.plist`, needs `sudo`):

```sh
~/.dotfiles/bin/osx
```

Keep the machine and the `Brewfile` in sync:

```sh
brew bundle check --verbose --file ~/.dotfiles/Brewfile   # declared but not installed
brew bundle cleanup --file ~/.dotfiles/Brewfile           # installed but not declared (dry run)
brew bundle --file ~/.dotfiles/Brewfile                   # install what is missing
```

Homebrew only loads packages from trusted third-party taps. On a new machine, if `brew bundle` refuses a tap, trust it first with `brew trust --tap <tap>`.

Migrating from another Mac:

```sh
# On the old machine — backs up SSH/GPG keys, cloud credentials, VS Code settings, .env files, Documents, and more
./mac_migration.sh /Volumes/Backup

# On the new machine — run the generated restore script, then rocknroll
```

## Structure

```
.dotfiles/
├── bin/
│   ├── rocknroll           # bootstrap: Homebrew + Brewfile + symlinks + git hooks + Fish as default shell
│   ├── osx                 # macOS defaults (trackpad, keyboard, Finder, Safari, UI) + maxfiles LaunchDaemon
│   └── symlink-dotfiles    # symlink manager (backs up real files it would replace)
├── fish/
│   ├── config.fish         # environment, PATH, integrations (gcloud, fzf, mise)
│   ├── conf.d/
│   │   └── aliases.fish    # abbreviations and aliases
│   └── functions/
│       ├── fish_prompt.fish # Pure-inspired prompt with git status
│       ├── fish_mode_prompt.fish # hides the vi-mode indicator
│       ├── ssh.fish         # ssh wrapper forcing TERM=xterm-256color for remote hosts
│       ├── dk-tail.fish     # Docker container watcher
│       ├── cct.fish         # Claude Code token/cost report (ccusage)
│       └── cclive.fish      # Live Claude Code billing-block monitor
├── Brewfile                # Homebrew formulae, casks and taps
├── limit.maxfiles.plist    # LaunchDaemon raising the open-files hard limit (installed by bin/osx)
├── .gitconfig              # aliases, diff tool, signing, performance tuning
├── .editorconfig           # project-wide formatting rules
├── .gitignore_global       # global gitignore
├── mise/
│   └── config.toml         # mise tool versions (node, ruby, go, python, java, uv, bun, yarn)
└── mac_migration.sh        # full workstation backup/restore
```

## Highlights

### Prompt

Pure-inspired, implemented from scratch in Fish. Two-line layout: path (blue), git branch (grey), dirty indicator (pink `*`), ahead `⇡` / behind `⇣` arrows (cyan), stash indicator `≡`, and elapsed time for commands over 5s (yellow). Prompt character `❯` turns red on error. User@host shown only on SSH or as root.

### Git workflow

Rebase-by-default, GPG signing on every commit, rerere, and fsmonitor + protocol v2 for performance. Standout aliases:

| Alias | What it does |
|-------|-------------|
| `wip` | Stage everything and commit "WIP" |
| `sync` | Rebase current branch onto main |
| `nevermind` | Hard reset + clean working tree |
| `please` | Force-push with lease |
| `precommit` | Review staged diff before committing |
| `rewrite` | Interactive rebase from merge-base |

### Modern CLI replacements

| Classic | Replacement |
|---------|------------|
| `cat` | `bat` |
| `ping` | `prettyping` |
| `du` | `ncdu` |
| `find` | `fd` |
| `diff` | `difftastic` |

### Claude Code token monitoring

Two wrappers around [`ccusage`](https://www.npmjs.com/package/ccusage) for tracking Claude Code token usage and cost. Everything is computed locally from the logs in `~/.claude/projects/` — nothing is uploaded.

| Command | What it does |
|---------|-------------|
| `cclive` | Live full-screen monitor of the current 5-hour billing block — cost, burn rate, % of token limit, time remaining. `Ctrl-C` to exit. |
| `cct` | Daily token/cost report |
| `cct monthly` | Monthly rollup |
| `cct session` | Per-session breakdown |
| `cct blocks` | All 5-hour blocks (non-live) |

Extra flags pass straight through, e.g. `cct --since 20260601` or `cct session --since 20260601`.

## Credits

- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles) for the macOS defaults script
- [Sindre Sorhus' Pure](https://github.com/sindresorhus/pure) for prompt design inspiration

## License

MIT — see [LICENSE](LICENSE)
