# Homebrew packages, installed by `bin/rocknroll` via `brew bundle`.
#
#   brew bundle --file ~/.dotfiles/Brewfile            # install anything missing
#   brew bundle check --verbose --file ~/.dotfiles/Brewfile   # what is declared but not installed
#   brew bundle cleanup --file ~/.dotfiles/Brewfile    # what is installed but not declared (dry run)
#
# Language runtimes (node, ruby, go, python, java, rust, uv, bun) are managed by mise
# (mise/config.toml), not here. Add new packages under the matching section.
#
# Third-party taps may need trusting on a new machine before their packages
# load: `brew trust --tap <tap>` for each `tap` line below.

tap "anomalyco/tap"
tap "bearer/tap"
tap "dagger/tap"
tap "grafana/grafana"
tap "homeport/tap"
tap "sheprd-labs/tap"
tap "stripe/stripe-cli"

# --- Core / System ---
brew "bash"
brew "fish"
brew "coreutils"
brew "make"
brew "gnu-tar"
brew "gnu-which"
brew "gnu-sed"
brew "gnupg"
brew "nano"
brew "tree"
brew "tmux"
brew "rsync"
brew "ssh-copy-id"
brew "wget"
brew "pv"
brew "zsh"

# --- Developer tools ---
brew "gh"
brew "git-lfs"
brew "difftastic"
brew "shellcheck"
brew "shfmt"
brew "editorconfig"
brew "editorconfig-checker"
brew "pre-commit"
brew "clang-format"
brew "cloc"
brew "bat"
brew "fd"
brew "fzf"
brew "jq"
brew "yq"
brew "tig"
brew "htop"
brew "ctop"
brew "ncdu"
brew "prettyping"
brew "httpie"
brew "httpstat"
brew "hadolint"
brew "yamllint"
brew "wrk"
brew "act"
brew "glab"
brew "git-filter-repo"
brew "k6"
brew "stripe/stripe-cli/stripe"

# --- Languages / Runtimes ---
brew "mise"
brew "composer"
brew "maven"

# --- Cloud / Infrastructure ---
brew "awscli"
brew "kubernetes-cli"
brew "ko"
brew "pulumi"
brew "dagger/tap/dagger"
brew "homeport/tap/dyff"
brew "trivy"
brew "grpcurl"
brew "tailscale"
brew "ansible"
brew "ansible-lint"
brew "rclone"

# --- Database ---
brew "postgresql@15"
brew "libpq" # keg-only client tools (psql, pg_dump); added to PATH in fish/config.fish
brew "pgcli"

# --- Networking ---
brew "mtr"
brew "iperf"
brew "netcat"
brew "mole"
brew "cloudflare-speed-cli"
brew "midnight-commander"

# --- Security ---
brew "pinentry-mac"

# --- Multimedia ---
brew "ffmpeg"
brew "ghostscript"
brew "poppler"
brew "yt-dlp"

# --- AI / LLM ---
brew "ollama"
brew "gemini-cli" # deprecated upstream ("unsupported"); drop once replaced
brew "llmfit"
brew "rtk"
brew "anomalyco/tap/opencode-v2"
brew "herdr"
brew "hunk"
brew "hermes-agent"
brew "bearer/tap/bearer"

# --- Other ---
brew "jupyterlab"
brew "phrase-cli"
brew "cmake"
brew "automake"
brew "subversion"

# --- C / C++ / embedded ---
brew "ninja"
brew "ccache"
brew "cppcheck"
brew "dfu-util"
brew "pkgconf" # pkg-config for C/C++ builds
brew "boost"
brew "googletest"
brew "rapidjson"

# --- Fonts ---
cask "font-fira-code"
cask "font-hack"
cask "font-geist-mono"
cask "font-symbols-only-nerd-font"

# --- Browsers ---
cask "firefox"
cask "brave-browser"

# --- Terminals / Editors ---
cask "ghostty"
cask "warp"
cask "zed"
cask "sublime-text"
cask "visual-studio-code"

# --- Development ---
cask "docker-desktop"
cask "android-studio"
cask "postman"
cask "tuist"

# --- Cloud ---
cask "gcloud-cli"
cask "tailscale-app"

# --- Communication ---
cask "telegram"
cask "whatsapp"
cask "signal"
cask "microsoft-teams"
cask "microsoft-auto-update" # updater microsoft-teams depends on
cask "loom"

# --- Security / VPN ---
cask "1password"
cask "1password-cli"
cask "gpg-suite"
cask "protonvpn"

# --- Utilities ---
cask "rocket"
cask "xquartz"
cask "onyx"
cask "spotify"
cask "vlc"
cask "space-rabbit"
cask "logi-options+"
cask "splashtop-business"

# --- AI ---
cask "opencode-desktop"
cask "sheprd"
cask "grafana-assistant"
