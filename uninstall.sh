#!/usr/bin/env sh

INSTALL_PATH='/usr/local/bin'
SRC_DIR='src'

EXIT_CODE=0

# colored text ANSI_color
colored() {
    printf '\033[%dm%s\033[0m' "$2" "$1"
}

uninstall() {
    name="$(basename "$1" .sh)"
    dest="$INSTALL_PATH/$name"

    printf 'uninstalling %-10s' "$name"

    if rm "$dest" 2> /dev/null
    then
        state='done'
        color=32    # green
    else
        EXIT_CODE=1
        state='failed'
        color=31    # red
    fi

    printf '\t[%s]\n' "$(colored "$state" "$color")"
}

if [ $# -eq 0 ]
then
    for script in "$SRC_DIR/"*
    do
        uninstall "$script"
    done
else
    for script
    do
        uninstall "$script"
    done
fi

return "$EXIT_CODE"
