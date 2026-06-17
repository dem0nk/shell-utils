# Shared variable management
# setvar    — set a named variable and export it across all tabs
# getvar    — get a variable's value
# rmvar     — remove a variable by name
# listvars  — list all currently set vars
# reloadvars — reload vars from file into current session

VARS_FILE="$HOME/.shell_vars"

setvar() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: setvar <name> <value>"
        return 1
    fi
    local name="$1"
    local value="$2"

    if grep -q "^export $name=" "$VARS_FILE" 2>/dev/null; then
        sed -i "s|^export $name=.*|export $name=\"$value\"|" "$VARS_FILE"
    else
        echo "export $name=\"$value\"" >> "$VARS_FILE"
    fi

    export "$name=$value"
    echo "Set $name=$value"
}

rmvar() {
    if [ -z "$1" ]; then
        echo "Usage: rmvar <name>"
        return 1
    fi
    local name="$1"

    sed -i "/^export $name=/d" "$VARS_FILE"
    unset "$name"
    echo "Removed $name"
}

listvars() {
    if [ ! -f "$VARS_FILE" ] || [ ! -s "$VARS_FILE" ]; then
        echo "No variables set."
        return 0
    fi
    cat "$VARS_FILE"
}

getvar() {
    if [ -z "$1" ]; then
        echo "Usage: getvar <name>"
        return 1
    fi
    local value
    value=$(grep "^export $1=" "$VARS_FILE" 2>/dev/null | cut -d'=' -f2- | tr -d '"')
    if [ -z "$value" ]; then
        echo "$1 is not set."
    else
        echo "$1=$value"
    fi
}

reloadvars() {
    if [ ! -f "$VARS_FILE" ] || [ ! -s "$VARS_FILE" ]; then
        echo "No variables to reload."
        return 0
    fi
    source "$VARS_FILE"
    echo "Variables reloaded."
}