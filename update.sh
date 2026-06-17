#!/usr/bin/env bash
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSHRC="$HOME/.zshrc"
MARKER="# shell-utils"

echo "Updating shell-utils..."
cd "$REPO_DIR" && git pull

# Add any new .zsh files that aren't sourced yet
for f in "$REPO_DIR"/functions/*.zsh; do
    if ! grep -q "$f" "$ZSHRC"; then
        echo "source $f" >> "$ZSHRC"
        echo "Added $f"
    fi
done

echo "Done. Run: source ~/.zshrc"