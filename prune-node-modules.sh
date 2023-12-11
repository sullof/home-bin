#!/usr/bin/env bash

# Function to safely delete node_modules
delete_node_modules() {
    local dir=$1
    echo "Deleting: $dir"
    rm -rf "$dir"
}

export -f delete_node_modules

# Main script
if [[ "$1" == "" ]]; then
    echo "Finding node_modules directories..."
    find . -name 'node_modules' -type d -prune
else
    echo "Deleting node_modules directories..."
    find . -name 'node_modules' -type d -prune -exec bash -c 'delete_node_modules "$0"' {} \;
fi
