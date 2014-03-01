#!/usr/bin/env bash

# I use this to load my $PATH variables
# It takes a given directory and if adds it
# to $PATH only if it exists, and it's not
# already part of $PATH.
function add_to_path {
    local dir
    
    for dir in "$@"; do
        if [ -d "$dir" ] && [[ ":$PATH:" != *":$dir:"* ]]; then
            PATH="$PATH:$dir"
        fi
    done

    # Remove leading or trailing `:`
    export PATH="$(echo "$PATH" | sed 's/^\://' | sed 's/\:$//')"
}
