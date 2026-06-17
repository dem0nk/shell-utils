# shell-utils

Personal shell utilities for zsh.

## Install

git clone https://github.com/yourname/shell-utils.git
cd shell-utils && ./install.sh && source ~/.zshrc

## Uninstall

./uninstall.sh && source ~/.zshrc

## Functions

### htb.zsh

| Function  | Usage                             | Description                                         |
| --------- | --------------------------------- | --------------------------------------------------- |
| mkhtb     | mkhtb <box>                       | Creates htb/<box>/nmap, cds in, starts tmux session |
| sethtb    | sethtb <ip> <host> [subdomain...] | Sets last /etc/hosts entry                          |
| sethtb -s | sethtb -s <subdomain>             | Appends subdomain to last entry                     |
| sethtb -r | sethtb -r <domain>                | Removes domain from last entry                      |
| getports  | getports [file]                   | Extracts open ports from gnmap file                 |

### fs.zsh

| Function | Usage                     | Description                              |
| -------- | ------------------------- | ---------------------------------------- |
| rmexcept | rmexcept <dir1> [dir2...] | Deletes everything except specified dirs |

## Adding new functions

Drop a new .zsh file into functions/ — it gets sourced automatically.
