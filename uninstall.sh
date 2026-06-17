#!/usr/bin/env bash
ZSHRC="$HOME/.zshrc"
MARKER="# shell-utils"

if ! grep -q "$MARKER" "$ZSHRC"; then
    echo "shell-utils not found in $ZSHRC"
    exit 0
fi

# Remove the marker line and the for loop that follows (3 lines total)
sed -i "/$MARKER/,+3d" "$ZSHRC"
echo "Uninstalled. Run: source ~/.zshrc"