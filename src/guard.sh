#!/usr/bin/env sh

# description
#     add C-style include guards to header files
#
# usage
#     guard [file ...]
#
# notes
#     any files (and intermediate directories) that do not exist will be
#     created
#
#     generated include guards contain a UUID to guarantee uniqueness
#
# author
#     Ujan RoyBandyopadhyay (2023)
#
# <https://github.com/ujan-r/scripts>

prefixed() {
    printf "#ifndef %s\n" "$1"
    printf "#define %s\n" "$1"
}

suffixed() {
    printf "#endif /* !%s */\n" "$1"
}

if [ "$#" -eq 0 ]; then
    guard="INCLUDE_GUARD_$(uuidgen | tr '-' '_')"
    printf "%s\n\n\n\n%s\n" "$(prefixed "$guard")" "$(suffixed "$guard")"
else
    for file
    do
        mkdir -p "$(dirname "$file")" && touch "$file"

        guard="INCLUDE_GUARD_$(uuidgen | tr '-' '_')"

        printf "%s\n\n%s\n\n%s\n"  \
            "$(prefixed "$guard")" \
            "$(cat "$file")"       \
            "$(suffixed "$guard")" \
        > "$file"
    done
fi
