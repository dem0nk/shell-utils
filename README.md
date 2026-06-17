# shell-utils

Personal shell utilities for zsh. Built for HTB and general use.

## Install

git clone https://github.com/dem0nk/shell-utils.git
cd shell-utils && ./install.sh

## Uninstall

./uninstall.sh

## Update

./update.sh

---

## Functions

### htb.zsh

Utilities for HTB workflow.

| Function  | Usage                                 | Description                                                           |
| --------- | ------------------------------------- | --------------------------------------------------------------------- |
| mkhtb     | mkhtb \<box\>                         | Creates htb/\<box\>/nmap, cds in, starts tmux session named after box |
| sethtb    | sethtb \<ip\> \<host\> [subdomain...] | Sets last /etc/hosts entry                                            |
| sethtb -s | sethtb -s \<subdomain\>               | Appends subdomain to last entry                                       |
| sethtb -r | sethtb -r \<domain\>                  | Removes domain from last entry                                        |
| getports  | getports [file]                       | Extracts open ports from gnmap file, defaults to nmap/init.gnmap      |

### fs.zsh

Filesystem utilities.

| Function | Usage                                       | Description                                                |
| -------- | ------------------------------------------- | ---------------------------------------------------------- |
| rmexcept | rmexcept \<directory\> \<keep1\> [keep2...] | Deletes everything inside directory except specified items |

### vars.zsh

Shared variable management across all tmux tabs and shell sessions.
Variables persist across sessions and are stored in ~/.shell_vars.

| Function   | Usage                     | Description                                      |
| ---------- | ------------------------- | ------------------------------------------------ |
| setvar     | setvar \<name\> \<value\> | Set a variable and write it to ~/.shell_vars     |
| getvar     | getvar \<name\>           | Get a variable's current value                   |
| rmvar      | rmvar \<name\>            | Remove a variable from session and ~/.shell_vars |
| listvars   | listvars                  | List all currently set variables                 |
| reloadvars | reloadvars                | Reload ~/.shell_vars into current tab            |

---

## How variables work across tabs

Variables are stored in `~/.shell_vars` and loaded on every new shell startup.
When you set a variable in one tab, other open tabs won't see it until they reload:

```zsh
# Tab 1
setvar domain 10.10.10.10

# Tab 2
reloadvars
echo $domain    # 10.10.10.10
```

---

## Adding new functions

Drop a new `.zsh` file into `functions/` and push to GitHub.
Running `update.sh` will pull the changes and add it to your shell automatically.
