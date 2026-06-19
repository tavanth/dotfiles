# dotfiles

Personal macOS dotfiles, managed with [GNU Stow](https://www.gnu.org/software/stow/) for clean, modular symlink management.

## Overview

Each package mirrors the directory structure it needs relative to `$HOME` (e.g. `nvim/.config/nvim/init.lua` → symlinked to `~/.config/nvim/init.lua`).

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
- Git
- macOS apps listed

Install Stow:

```bash
brew install stow
```

## Installation

Clone the repo into your home directory and run the bootstrap script:

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
./boot.sh
```

## Directory Structure

```
.dotfiles/
├── boot.sh
├── README.md
├── .gitignore
├── .gitmodules
├── nvim/
│   └── .config/nvim/...
├── tmux/
│   └── .config/tmux/...
├── zsh/
│   └── .zshrc
├── starship/
│   └── .config/starship.toml
├── ghostty/
│   └── .config/ghostty/...
├── iterm2/
│   └── .config/iterm2/...
├── sketchybar/
│   └── .config/sketchybar/...
└── zed/
    └── .config/zed/...
```

## Managing Changes

**Add a new tool:**

1. Create a new package folder: `mkdir -p newtool/.config/newtool`
2. Move the existing config into that path
3. Stow it: `stow newtool`

**On a new machine:**

```bash
git clone <your-repo-url> ~/.dotfiles
cd ~/.dotfiles
./boot.sh
```
