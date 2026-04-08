# dotfiles

macOS development environment. One command to bootstrap a new machine — Fish shell, 100+ Homebrew packages, opinionated Git, and sane macOS defaults.

[![License](https://img.shields.io/github/license/gyndav/dotfiles)](LICENSE)
[![macOS](https://img.shields.io/badge/macOS-Sequoia-000000?logo=apple&logoColor=white)](bin/osx)
[![Fish](https://img.shields.io/badge/shell-fish-34C534)](fish/)
[![Homebrew](https://img.shields.io/badge/homebrew-100%2B_packages-FBB040?logo=homebrew)](bin/rocknroll)

---

- **Fish shell** — Pure-inspired prompt, smart aliases, modern CLI replacements (`bat`, `fd`, `fzf`, `prettyping`, `ncdu`)
- **Git** — 36 aliases, GPG signing, difftastic diffs, performance tuning (fsmonitor, protocol v2, rerere)
- **Homebrew** — 80+ formulae + 20+ casks: dev tools, cloud/infra CLIs, editors, fonts, security, AI/LLM tooling
- **macOS defaults** — trackpad, keyboard, Finder, Safari, and UI preferences
- **Languages** — Node 24, Ruby 3.4, Go 1.26, Python 3.14, Java 17 via mise
- **Mac migration** — full backup/restore script for moving to a new machine

## Setup

Clone and run the bootstrap:

```sh
git clone https://github.com/gyndav/dotfiles.git ~/.dotfiles
~/.dotfiles/bin/rocknroll
```

`rocknroll` installs Homebrew (if missing), all formulae and casks, symlinks dotfiles, and sets Fish as the default shell.

Apply opinionated macOS preferences:

```sh
~/.dotfiles/bin/osx
```

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
│   ├── rocknroll           # bootstrap: Homebrew + casks + symlinks + set Fish as default shell
│   ├── osx                 # macOS defaults (trackpad, keyboard, Finder, Safari, UI)
│   └── symlink-dotfiles    # symlink manager
├── fish/
│   ├── config.fish         # environment, PATH, integrations (gcloud, fzf, mise)
│   ├── conf.d/
│   │   └── aliases.fish    # abbreviations and aliases
│   └── functions/
│       ├── fish_prompt.fish # Pure-inspired prompt with git status
│       └── dk-tail.fish     # Docker container watcher
├── .gitconfig              # aliases, diff tool, signing, performance tuning
├── .editorconfig           # project-wide formatting rules
├── .gitignore_global       # global gitignore
├── mise/
│   └── config.toml         # mise tool versions (node, ruby, go, python, java, uv)
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
| `sync` | Rebase current branch onto master |
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

## Credits

- [Mathias Bynens' dotfiles](https://github.com/mathiasbynens/dotfiles) for the macOS defaults script
- [Sindre Sorhus' Pure](https://github.com/sindresorhus/pure) for prompt design inspiration

## License

MIT — see [LICENSE](LICENSE)
