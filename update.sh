#!/usr/bin/env bash
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Updating shell-utils..."
cd "$REPO_DIR" && git pull || { echo "Update failed."; exit 1; }

zsh -c "source $HOME/.zshrc"
echo "Done."