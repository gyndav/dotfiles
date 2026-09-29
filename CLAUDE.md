# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal macOS dotfiles (Fish shell, Git, mise, Homebrew, macOS defaults). The repo is expected to live at `~/.dotfiles` — scripts hard-code that path. There is no build or test suite.

## How files reach the system

Config files are not read from the repo; `bin/symlink-dotfiles` symlinks them into `$HOME` (the `bin/` scripts themselves run in place):

- `.editorconfig`, `.gemrc`, `.gitconfig`, `.gitignore_global` → `~/.<name>` (explicit list in the script — a new top-level dotfile must be added to that list)
- `mise/config.toml` → `~/.config/mise/config.toml`
- `fish/config.fish` → `~/.config/fish/config.fish`
- `fish/conf.d/*.fish` and `fish/functions/*.fish` → per-file symlinks into `~/.config/fish/{conf.d,functions}/` (a new file there needs `bin/symlink-dotfiles` re-run to be picked up)

Not symlinked: `.gitignore` and `.prettierrc` (repo-local), `limit.maxfiles.plist` (installed manually with `sudo cp limit.maxfiles.plist /Library/LaunchDaemons/ && sudo launchctl load -w /Library/LaunchDaemons/limit.maxfiles.plist`; it raises the hard limit that the `ulimit -n 65536` in `fish/config.fish` depends on).

`bin/rocknroll` is the full bootstrap: installs Homebrew, a long list of `brew install` / `brew install --cask` lines (grouped by comment headers — add new packages under the matching section), runs `symlink-dotfiles`, sets Fish as the login shell, and creates `~/.localrc.fish`. `bin/osx` applies macOS `defaults`. `mac_migration.sh` backs up an old machine to a destination path.

## Commands

```sh
lefthook run pre-commit --all-files      # every lint check, same as CI
lefthook run pre-commit --all-files --job shellcheck    # a single check
fish_indent -w <file>                    # fix fish formatting
shfmt -w <file>                          # fix shell formatting
bin/symlink-dotfiles                     # re-link after adding/renaming files
exec fish                                # reload shell (abbr: reload)
```

## Linting and CI

`lefthook.yml` defines the checks: `fish_indent --check` and `fish -n` on fish files, `shellcheck` + `shfmt` on shell scripts (`bin/*`, `*.sh`, `.lefthook/*`), `editorconfig-checker` on everything, `actionlint` on workflows, and a `commit-msg` hook (`.lefthook/check-commit-msg`) enforcing Conventional Commits. Lint tool versions are pinned in the root `mise.toml` (separate from `mise/config.toml`, which is the global toolchain symlinked into `$HOME`); `fish` itself comes from Homebrew. `bin/rocknroll` installs the hooks.

`.github/workflows/lint.yml` runs the same pre-commit jobs on macOS, plus the commit-message check on every PR commit and on the PR title (the squash-merge subject). When adding a new kind of file, add its check to `lefthook.yml` rather than to the workflow.

## Conventions

- `fish/config.fish` is the single source of truth for `PATH`: it erases universal `fish_user_paths` on every start and rebuilds it with `fish_add_path --global`. Never use universal `fish_add_path` or `set -U` for paths; add entries to the ordered list in `config.fish` (mise shims first, then `/usr/local/bin` ahead of Homebrew so GPG Suite's `gpg` wins; bun/docker appended at lowest priority).
- Machine-specific/secret settings go in `~/.localrc.fish` (sourced last, unversioned), not in this repo.
- `fish/conf.d/aliases.fish` returns early when not interactive so aliases like `cat → bat` never affect scripts or `fish -c`. Use `abbr` for plain shortcuts and `alias` for command wrappers.
- Formatting follows each language's standard tool, encoded in `.editorconfig`: fish files are `fish_indent` output (4 spaces), shell scripts are 2-space (`shfmt`), `.gitconfig` uses tabs. LF everywhere.
- Language versions are managed by mise (`mise/config.toml`), not Homebrew or asdf.
- Commits and PR titles follow [Conventional Commits](https://www.conventionalcommits.org/) with the area as scope: `fix(fish): …`, `feat(mise): …`, `chore(gitconfig): …`, `docs(readme): …`. Older history uses a bare `<area>: …` prefix or plain sentences; don't copy those.
- The README's Structure tree lists every file under `fish/functions/`; add a line there when adding a function.
