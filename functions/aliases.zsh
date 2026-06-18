# Alias management
# setalias  — add or update an alias
# rmalias   — remove an alias
# listalias — list all aliases

ALIASES_FILE="$HOME/.shell_aliases"

# Source on shell startup
[ -f "$ALIASES_FILE" ] && source "$ALIASES_FILE"

setalias() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: setalias <name> <command>"
        return 1
    fi
    local name="$1"
    shift
    local cmd="$*"

    if grep -q "^alias $name=" "$ALIASES_FILE" 2>/dev/null; then
        sed -i "s|^alias $name=.*|alias $name='$cmd'|" "$ALIASES_FILE"
    else
        echo "alias $name='$cmd'" >> "$ALIASES_FILE"
    fi

    alias "$name=$cmd"
    echo "Set alias $name='$cmd'"
}

rmalias() {
    if [ -z "$1" ]; then
        echo "Usage: rmalias <name>"
        return 1
    fi
    sed -i "/^alias $1=/d" "$ALIASES_FILE"
    unalias "$1" 2>/dev/null
    echo "Removed alias $1"
}

listalias() {
    if [ ! -f "$ALIASES_FILE" ] || [ ! -s "$ALIASES_FILE" ]; then
        echo "No aliases set."
        return 0
    fi
    cat "$ALIASES_FILE"
}