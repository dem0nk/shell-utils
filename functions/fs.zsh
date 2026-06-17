#!/usr/bin/env zsh
# Filesystem Utilities
# rmexcept — rm -rf everything except specified directories

setopt extendedglob

rmexcept() {
    if [ "$#" -lt 1 ]; then
        echo "Usage: rmexcept <dir1> [dir2] [dir3] ..."
        return 1
    fi
    local pattern
    pattern=$(IFS='|'; echo "$*")
    rm -rf ^($pattern)
}