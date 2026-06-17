# HTB Utilities
# mkhtb  — create box directory structure and start tmux session
# sethtb — manage /etc/hosts entries for HTB boxes
# getports — extract open ports from nmap gnmap output

mkhtb() {
    if [ -z "$1" ]; then
        echo "Usage: mkhtb <box-name>"
        return 1
    fi
    local box="htb/$1"
    mkdir -p "$box/nmap" && cd "$box" && tmux new-session -s "$1"
}

sethtb() {
    if [ "$1" == "-s" ]; then
        if [ -z "$2" ]; then
            echo "Usage: sethtb -s <Subdomain>"
            return 1
        fi
        sudo sed -i "\$s/$/ $2/" /etc/hosts
        echo "Added $2 to the last entry."

    elif [ "$1" == "-r" ]; then
        if [ -z "$2" ]; then
            echo "Usage: sethtb -r <DomainToRemove>"
            return 1
        fi
        local target="$2"
        local current_line
        current_line=$(sudo tail -n 1 /etc/hosts)

        local escaped_target
        escaped_target=$(printf '%s' "$target" | sed 's/[.[\*^$]/\\&/g')

        local new_line
        new_line=$(echo "$current_line" | sed "s/ $escaped_target//g; s/  */ /g; s/ *$//")

        if [ -z "$(echo "$new_line" | awk '{print $2}')" ]; then
            echo "Warning: No hostnames left. Removing the last line."
            sudo sed -i '$d' /etc/hosts
        else
            sudo sed -i "\$c\\$new_line" /etc/hosts
            echo "Removed $target from the last entry."
        fi

    else
        if [ "$#" -lt 2 ]; then
            echo "Usage: sethtb <IP> <Hostname> [Subdomain...]"
            echo "       sethtb -s <Subdomain>"
            echo "       sethtb -r <DomainToRemove>"
            return 1
        fi
        local ip="$1"
        shift
        local hostnames="$*"
        sudo sed -i "$ s/.*/$ip\t$hostnames/" /etc/hosts
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