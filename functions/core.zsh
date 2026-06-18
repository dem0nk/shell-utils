# Core utilities
# sourcef — source all shell-utils managed files

VARS_FILE="$HOME/.shell_vars"
ALIASES_FILE="$HOME/.shell_aliases"

sourcef() {
    [ -f "$VARS_FILE" ] && source "$VARS_FILE" && echo "Sourced $VARS_FILE"
    [ -f "$ALIASES_FILE" ] && source "$ALIASES_FILE" && echo "Sourced $ALIASES_FILE"
}