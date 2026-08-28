# Filesystem Utilities
# rmexcept — rm -rf everything except specified directories
rmexcept() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: rmexcept <dir> <keep1> [keep2] ..."
        return 1
    fi
    local target="$1"
    shift
    if [ ! -d "$target" ]; then
        echo "Error: $target is not a directory"
        return 1
    fi
    
    # Use an array to safely handle filenames with spaces/special chars
    local args=()
    for dir in "$@"; do
        args+=(! -name "$dir")
    done
    
    find "$target" -mindepth 1 -maxdepth 1 "${args[@]}" -exec rm -rf {} +
}