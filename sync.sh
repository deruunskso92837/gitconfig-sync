#!/usr/bin/env bash
# gitconfig-sync - Sync git config and hooks from a dotfiles repo.
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-$HOME/.dotfiles}"
GIT_HOOKS_DIR="${GIT_HOOKS_DIR:-$HOME/.git-hooks}"

echo "Syncing git configuration..."

# Sync .gitconfig
if [ -f "$DOTFILES_REPO/.gitconfig" ]; then
  cp "$DOTFILES_REPO/.gitconfig" "$HOME/.gitconfig"
  echo "  Synced .gitconfig"
fi

# Sync global hooks
if [ -d "$DOTFILES_REPO/git-hooks" ]; then
  mkdir -p "$GIT_HOOKS_DIR"
  cp -r "$DOTFILES_REPO/git-hooks/"* "$GIT_HOOKS_DIR/"
  chmod +x "$GIT_HOOKS_DIR/"*
  git config --global core.hooksPath "$GIT_HOOKS_DIR"
  echo "  Synced $(ls "$GIT_HOOKS_DIR" | wc -l) hooks to $GIT_HOOKS_DIR"
fi

echo "Done."
