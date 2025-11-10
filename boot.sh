#!/usr/bin/env bash
set -e

DOTFILES="$HOME/.dotfiles"
BREWFILE="$DOTFILES/Brewfile"

# if brew missing
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv || true)"
fi

if [ -f "$BREWFILE" ]; then
  brew bundle --file="$BREWFILE"
fi

ln -sf "$DOTFILES/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/.gitconfig" "$HOME/.gitconfig"
ln -sfn "$DOTFILES/.config" "$HOME/.config"

echo "Bootstrap complete."

