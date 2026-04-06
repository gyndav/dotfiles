#!/bin/bash

# MacBook Migration Script for Engineering Workstation
# Usage: Run this on your OLD Mac to copy files to an external drive or network location

set -e

# Configuration
DEST="${1:-/Volumes/Migration}" # Default to external drive, or pass custom path
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$DEST/mac_backup_$TIMESTAMP"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Verify destination exists
if [[ ! -d "$DEST" ]]; then
  log_error "Destination '$DEST' does not exist."
  echo "Usage: $0 /path/to/destination"
  echo "Example: $0 /Volumes/MyUSBDrive"
  exit 1
fi

log_info "Creating backup directory: $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Function to safely copy files/directories
safe_copy() {
  local src="$1"
  local dest_subdir="$2"
  local dest_path="$BACKUP_DIR/$dest_subdir"

  if [[ -e "$src" ]]; then
    mkdir -p "$(dirname "$dest_path")"
    cp -R "$src" "$dest_path" 2>/dev/null &&
      log_info "Copied: $src" ||
      log_warn "Failed to copy: $src"
  else
    log_warn "Not found: $src"
  fi
}

echo ""
echo "=========================================="
echo "  MacBook Engineering Migration Script"
echo "=========================================="
echo ""

# ============================================
# CRITICAL: SSH & Security Keys
# ============================================
log_info "=== Copying SSH & Security Keys ==="
safe_copy "$HOME/.ssh" "ssh"
safe_copy "$HOME/.gnupg" "gnupg"

# ============================================
# Git Configuration
# ============================================
log_info "=== Copying Git Configuration ==="
safe_copy "$HOME/.git-credentials" "git/git-credentials"

# ============================================
# Shell Configuration
# ============================================
log_info "=== Copying Shell Configuration ==="
safe_copy "$HOME/.localrc" "shell/localrc"
safe_copy "$HOME/.localrc.fish" "shell/localrc.fish"

# ============================================
# Development Environment
# ============================================
log_info "=== Copying Development Environment ==="
safe_copy "$HOME/.config" "config"
safe_copy "$HOME/.npmrc" "node/npmrc"
safe_copy "$HOME/.gemrc" "ruby/gemrc"
safe_copy "$HOME/.irbrc" "ruby/irbrc"
safe_copy "$HOME/.pryrc" "ruby/pryrc"

# ============================================
# Cloud & CI/CD Credentials
# ============================================
log_info "=== Copying Cloud Credentials ==="
safe_copy "$HOME/.aws" "cloud/aws"
safe_copy "$HOME/.config/gcloud" "cloud/gcloud"
safe_copy "$HOME/Library/Application Support/firebase" "cloud/firebase"

# ============================================
# IDE/Editor Configuration
# ============================================
log_info "=== Copying IDE Configuration ==="

# VS Code
VSCODE_USER="$HOME/Library/Application Support/Code/User"
if [[ -d "$VSCODE_USER" ]]; then
  mkdir -p "$BACKUP_DIR/vscode"
  safe_copy "$VSCODE_USER/settings.json" "vscode/settings.json"
  safe_copy "$VSCODE_USER/keybindings.json" "vscode/keybindings.json"
  safe_copy "$VSCODE_USER/snippets" "vscode/snippets"

  # Export extensions list
  if command -v code &>/dev/null; then
    code --list-extensions >"$BACKUP_DIR/vscode/extensions.txt" &&
      log_info "Exported VS Code extensions list"
  fi
fi

# ============================================
# Homebrew Package List
# ============================================
log_info "=== Exporting Homebrew Packages ==="
if command -v brew &>/dev/null; then
  mkdir -p "$BACKUP_DIR/homebrew"
  brew bundle dump --file="$BACKUP_DIR/homebrew/Brewfile" --force &&
    log_info "Exported Brewfile"
  brew list --formula >"$BACKUP_DIR/homebrew/formula_list.txt"
  brew list --cask >"$BACKUP_DIR/homebrew/cask_list.txt"
fi

# ============================================
# Environment Files from Projects
# ============================================
log_info "=== Looking for .env files in common project locations ==="
mkdir -p "$BACKUP_DIR/env_files"

# Search common project directories
for proj_dir in "$HOME/Projects" "$HOME/Code" "$HOME/Development" "$HOME/repos" "$HOME/work"; do
  if [[ -d "$proj_dir" ]]; then
    log_info "Scanning $proj_dir for .env files..."
    find "$proj_dir" -maxdepth 3 -name ".env*" -type f 2>/dev/null | while read -r env_file; do
      rel_path="${env_file#$HOME/}"
      dest_file="$BACKUP_DIR/env_files/${rel_path//\//_}"
      cp "$env_file" "$dest_file" 2>/dev/null &&
        log_info "Found: $env_file"
    done
  fi
done

# ============================================
# Compress Documents and Downloads
# ============================================
log_info "=== Compressing Documents and Downloads directories ==="
mkdir -p "$BACKUP_DIR/user_data"

# Function to compress directory with progress
compress_directory() {
  local src_dir="$1"
  local archive_name="$2"
  local dest_archive="$BACKUP_DIR/user_data/$archive_name"

  if [[ -d "$src_dir" ]]; then
    log_info "Compressing $(basename "$src_dir")... (this may take a while)"

    # Count files for progress indication
    local file_count=$(find "$src_dir" -type f 2>/dev/null | wc -l | tr -d ' ')
    log_info "Found $file_count files in $(basename "$src_dir")"

    # Create tar.gz archive
    tar -czf "$dest_archive" -C "$(dirname "$src_dir")" "$(basename "$src_dir")" 2>/dev/null &&
      log_info "Successfully compressed: $archive_name ($(du -h "$dest_archive" | cut -f1))" ||
      log_error "Failed to compress: $src_dir"
  else
    log_warn "Directory not found: $src_dir"
  fi
}

# Compress Documents
compress_directory "$HOME/Documents" "Documents.tar.gz"

# Compress Downloads
compress_directory "$HOME/Downloads" "Downloads.tar.gz"

# ============================================
# Create Restore Script
# ============================================
log_info "=== Creating restore script ==="
cat >"$BACKUP_DIR/restore.sh" <<'RESTORE_SCRIPT'
#!/bin/bash

# Restore script - run this on your NEW Mac
# Usage: ./restore.sh /path/to/backup_directory

set -e

BACKUP_DIR="${1:-.}"
HOME_DIR="$HOME"

log_info() { echo -e "\033[0;32m[INFO]\033[0m $1"; }
log_warn() { echo -e "\033[1;33m[WARN]\033[0m $1"; }

safe_restore() {
    local src="$1"
    local dest="$2"

    if [[ -e "$src" ]]; then
        mkdir -p "$(dirname "$dest")"
        if [[ -e "$dest" ]]; then
            log_warn "Exists, backing up: $dest"
            mv "$dest" "${dest}.backup_$(date +%s)"
        fi
        cp -R "$src" "$dest" && log_info "Restored: $dest"
    fi
}

echo "Restoring from: $BACKUP_DIR"
echo ""

# SSH & GPG
safe_restore "$BACKUP_DIR/ssh" "$HOME_DIR/.ssh"
chmod 700 "$HOME_DIR/.ssh" 2>/dev/null
chmod 600 "$HOME_DIR/.ssh/"* 2>/dev/null
safe_restore "$BACKUP_DIR/gnupg" "$HOME_DIR/.gnupg"

# Git
safe_restore "$BACKUP_DIR/git/gitconfig" "$HOME_DIR/.git-credentials"
safe_restore "$BACKUP_DIR/git/gitignore_global" "$HOME_DIR/.gitignore_global"

# Shell
safe_restore "$BACKUP_DIR/shell/localrc" "$HOME_DIR/.localrc"
safe_restore "$BACKUP_DIR/shell/localrc.fish" "$HOME_DIR/.localrc.fish"

# Config
safe_restore "$BACKUP_DIR/config" "$HOME_DIR/.config"

# Cloud
safe_restore "$BACKUP_DIR/cloud/aws" "$HOME_DIR/.aws"

# Database
safe_restore "$BACKUP_DIR/database/pgpass" "$HOME_DIR/.pgpass"
chmod 600 "$HOME_DIR/.pgpass" 2>/dev/null

# VS Code
if [[ -d "$BACKUP_DIR/vscode" ]]; then
    VSCODE_USER="$HOME_DIR/Library/Application Support/Code/User"
    mkdir -p "$VSCODE_USER"
    safe_restore "$BACKUP_DIR/vscode/settings.json" "$VSCODE_USER/settings.json"
    safe_restore "$BACKUP_DIR/vscode/keybindings.json" "$VSCODE_USER/keybindings.json"
    safe_restore "$BACKUP_DIR/vscode/snippets" "$VSCODE_USER/snippets"

    # Install extensions
    if [[ -f "$BACKUP_DIR/vscode/extensions.txt" ]] && command -v code &> /dev/null; then
        log_info "Installing VS Code extensions..."
        cat "$BACKUP_DIR/vscode/extensions.txt" | xargs -L 1 code --install-extension
    fi
fi

# Homebrew
if [[ -f "$BACKUP_DIR/homebrew/Brewfile" ]]; then
    if ! command -v brew &> /dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    log_info "Installing Homebrew packages..."
    brew bundle --file="$BACKUP_DIR/homebrew/Brewfile"
fi

# Restore Documents and Downloads
log_info "=== Restoring Documents and Downloads ==="

restore_archive() {
    local archive="$1"
    local dest_dir="$2"

    if [[ -f "$archive" ]]; then
        log_info "Extracting $(basename "$archive")... (this may take a while)"

        # Backup existing directory if it exists and is not empty
        if [[ -d "$dest_dir" ]] && [[ -n "$(ls -A "$dest_dir" 2>/dev/null)" ]]; then
            local backup_name="${dest_dir}_backup_$(date +%s)"
            log_warn "Backing up existing directory to: $backup_name"
            mv "$dest_dir" "$backup_name"
        fi

        # Extract archive
        mkdir -p "$(dirname "$dest_dir")"
        tar -xzf "$archive" -C "$HOME_DIR" 2>/dev/null &&
            log_info "Successfully restored: $(basename "$dest_dir")" ||
            log_warn "Failed to extract: $(basename "$archive")"
    else
        log_warn "Archive not found: $(basename "$archive")"
    fi
}

if [[ -d "$BACKUP_DIR/user_data" ]]; then
    restore_archive "$BACKUP_DIR/user_data/Documents.tar.gz" "$HOME_DIR/Documents"
    restore_archive "$BACKUP_DIR/user_data/Downloads.tar.gz" "$HOME_DIR/Downloads"
fi

echo ""
echo "=========================================="
echo "  Restore complete!"
echo "=========================================="
echo ""
echo "Post-restore steps:"
echo "  1. Restart your terminal"
echo "  2. Test SSH: ssh -T git@github.com"
echo "  3. Re-authenticate cloud CLIs (firebase, gcloud, aws)"
echo "  4. Check .env files in: $BACKUP_DIR/env_files/"
echo "  5. Verify Documents and Downloads were restored correctly"
echo ""
RESTORE_SCRIPT

chmod +x "$BACKUP_DIR/restore.sh"

# ============================================
# Summary
# ============================================
echo ""
echo "=========================================="
echo "  Migration Backup Complete!"
echo "=========================================="
echo ""
echo "Backup location: $BACKUP_DIR"
echo ""
echo "Backup size:"
du -sh "$BACKUP_DIR"
echo ""
echo "Next steps:"
echo "  1. Copy $BACKUP_DIR to your new Mac"
echo "  2. Run: ./restore.sh"
echo "  3. Review .env files manually"
echo ""
echo "Included in backup:"
echo "  - Configuration files and directories"
echo "  - Documents directory (compressed)"
echo "  - Downloads directory (compressed)"
echo "  - VS Code settings and extensions"
echo "  - Homebrew packages list"
echo ""
log_warn "Remember to securely delete this backup after migration!"
