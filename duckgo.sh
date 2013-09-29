#!/bin/bash

set -e

# curl -s http://api.duckduckgo.com/\?no_html\=1\&format\=xml\&q\="$*" | hxselect -c "Answer";

response=$(curl -s http://api.duckduckgo.com/\?no_html\=1\&format\=xml\&q\="$*");

# Try to get "Abstract"
found="Abstract";
result=$(echo -e "$response" | hxselect -c "Abstract");

# If Abstract is empty, try to get "Definition"
if [ -z "$result" ]; then
    found="Definition";
    result=$(echo -e "$response" | hxselect -c 'Definition');
fi

# If Definition is empty, try to get all "Text" results
if [ -z "$result" ]; then
    found="Text";
    result=$(echo -e "$response" | hxselect -c -s '\n\n' 'Text');
fi

if [ -z "$result" ]; then
    found="";
    result="No results.";
fi

[ -n "$found" ] && echo "Results from '$found'.";
echo -e "$result";
echo;
