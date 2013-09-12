#!/usr/bin/env bash
# > add-apt-key reimplementation/clone
# - add multiple keys at once
# - tries several common keyservers
# - can use long or short keyid

if [ $# -eq 0 ]; then
    echo "Usage: $0 <key1> <key2> ... <keyN"
    exit 1
fi

# keyservers to try
s[1]='subkeys.pgp.net'
s[2]='keys.gnupg.net'
s[3]='keyring.debian.org'
s[4]='keyserver.ubuntu.com'
s[5]='pgp.mit.edu'

for key in "$@"; do
    for srv in "${s[@]}" ; do
        # --keyserver-options timeout=5
        gpg --keyserver "$srv" --recv-keys "$key"
        if [ "$?" -eq 0 ]; then
            gpg --export --armor "$key" | sudo apt-key add -
            break; # break inner loop
        fi
    done
done
