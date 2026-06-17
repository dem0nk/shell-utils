# Filesystem Utilities
# rmexcept — rm -rf everything except specified directories

rmexcept() {
    if [ "$#" -lt 2 ]; then
        echo "Usage: rmexcept <directory> <keep1> [keep2] ..."
        return 1
    fi

    local target="$1"
    shift

    if [ ! -d "$target" ]; then
        echo "Error: $target is not a directory"
        return 1
    fi

    local excludes=""
    for dir in "$@"; do
        excludes="$excludes ! -name \"$dir\""
    done

    eval find "$target" -mindepth 1 -maxdepth 1 $excludes -exec rm -rf {} +
}