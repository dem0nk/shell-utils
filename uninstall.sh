#!/usr/bin/env bash
ZSHRC="$HOME/.zshrc"
MARKER="# shell-utils"
END_MARKER="# end shell-utils"

if ! grep -q "$MARKER" "$ZSHRC"; then
    echo "shell-utils not found in $ZSHRC"
    exit 0
fi

# Remove the block cleanly from MARKER to END_MARKER
sed -i "/$MARKER/,/$END_MARKER/d" "$ZSHRC"
echo "Uninstalled. Run: source ~/.zshrc"