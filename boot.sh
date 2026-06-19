#!/usr/bin/env bash
set -e

DOTFILES="$HOME/.dotfiles"
BREWFILE="$DOTFILES/Brewfile"

# 1. Install Homebrew if missing
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# 2. Install apps from Brewfile
if [ -f "$BREWFILE" ]; then
  brew bundle --file="$BREWFILE"
fi

# 3. Ensure Stow is installed
if ! command -v stow &>/dev/null; then
  brew install stow
fi

mkdir -p "$HOME/.config"

cd "$DOTFILES"
stow aerospace ghostty git iterm2 nvim sketchybar starship tmux zed zsh

echo "Bootstrap complete!"
