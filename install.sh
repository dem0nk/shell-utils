#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSHRC="$HOME/.zshrc"
MARKER="# shell-utils"

if grep -q "$MARKER" "$ZSHRC"; then
    echo "shell-utils already installed."
    exit 0
fi

cat >> "$ZSHRC" <<EOF

$MARKER
[ -f "\$HOME/.shell_vars" ] && source "\$HOME/.shell_vars"

for f in "$REPO_DIR"/functions/*.zsh; do
    source "\$f"
done
EOF

echo "Installed. Run: source ~/.zshrc"