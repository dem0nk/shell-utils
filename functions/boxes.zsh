# Box Utilities (Generalized for HTB, OSCP, THM, etc.)
# mkbox   — create box directory structure and start tmux session
# setbox  — manage /etc/hosts entries for target boxes
# getports— extract open ports from nmap gnmap output

mkbox() {
    local base_dir="htb" # Default to htb
    
    # Parse flags
    local OPTIND
    while getopts ":HOD:" opt; do
        case ${opt} in
            H ) base_dir="htb" ;;
            O ) base_dir="oscp" ;;
            D ) base_dir="$OPTARG" ;;
            \? ) echo "Usage: mkbox [-H | -O | -D <dir>] <box-name>"; return 1 ;;
            : ) echo "Error: -D requires a directory argument."; return 1 ;;
        esac
    done
    shift $((OPTIND -1))

    local box_name="$1"
    if [ -z "$box_name" ]; then
        echo "Usage: mkbox [-H | -O | -D <dir>] <box-name>"
        echo "  -H  Hack The Box (defaults to htb/)"
        echo "  -O  OSCP (uses oscp/)"
        echo "  -D  Custom directory (e.g., -D thm)"
        return 1
    fi

    local box_path="${base_dir}/${box_name}"
    # Added -A to attach to session if it already exists
    mkdir -p "$box_path/nmap" && cd "$box_path" && tmux new-session -A -s "$box_name"
}

setbox() {
    if [ "$1" == "-s" ]; then
        if [ -z "$2" ]; then
            echo "Usage: setbox -s <Subdomain>"
            return 1
        fi
        sudo sed -i "\$s/$/ $2/" /etc/hosts
        echo "Added $2 to the last entry."

    elif [ "$1" == "-r" ]; then
        if [ -z "$2" ]; then
            echo "Usage: setbox -r <DomainToRemove>"
            return 1
        fi
        local target="$2"
        local current_line
        current_line=$(sudo tail -n 1 /etc/hosts)

        local escaped_target
        escaped_target=$(printf '%s' "$target" | sed 's/[.[\*^$]/\\&/g')

        local new_line
        # Match spaces or tabs, and collapse them properly
        new_line=$(echo "$current_line" | sed "s/[[:space:]]$escaped_target//g; s/[[:space:]]\{1,\}/ /g; s/[[:space:]]*$//")

        if [ -z "$(echo "$new_line" | awk '{print $2}')" ]; then
            echo "Warning: No hostnames left. Removing the last line."
            sudo sed -i '$d' /etc/hosts
        else
            sudo sed -i "\$c\\$new_line" /etc/hosts
            echo "Removed $target from the last entry."
        fi

    else
        if [ "$#" -lt 2 ]; then
            echo "Usage: setbox <IP> <Hostname> [Subdomain...]"
            echo "       setbox -s <Subdomain>"
            echo "       setbox -r <DomainToRemove>"
            return 1
        fi
        local ip="$1"
        shift
        local hostnames="$*"
        # Changed sed delimiter to | to avoid conflicts with slashes
        sudo sed -i "\$ s|.*|$ip\t$hostnames|" /etc/hosts
    fi
}

getports() {
    local file="${1:-nmap/init.gnmap}"
    if [ ! -f "$file" ]; then
        echo "Error: $file not found" >&2
        return 1
    fi
    grep -oP '\d{1,5}(?=/open)' "$file" | paste -sd ','
    echo ""
}