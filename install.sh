#!/usr/bin/env bash
set -e
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ZSHRC="$HOME/.zshrc"
MARKER="# shell-utils"
END_MARKER="# end shell-utils"

# Ensure .zshrc exists before trying to grep it
touch "$ZSHRC" 2>/dev/null

if grep -q "$MARKER" "$ZSHRC"; then
    echo "shell-utils already installed."
    exit 0
fi

cat >> "$ZSHRC" <<EOF
 $MARKER
[ -f "\$HOME/.shell_vars" ] && source "\$HOME/.shell_vars"
[ -f "\$HOME/.shell_aliases" ] && source "\$HOME/.shell_aliases"
for f in "$REPO_DIR"/functions/*.zsh; do
    [ -e "\$f" ] || continue
    source "\$f"
done
 $END_MARKER
EOF

echo "Installed. Run: source ~/.zshrc"