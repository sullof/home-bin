#!/bin/bash

# The Git repository URL passed as the first argument
repo_url="$1"

# Regular expression for validating Git repository URLs
regex="^git@([A-Za-z0-9_.]+):([A-Za-z0-9_./-]+)\.git$"

if [[ $repo_url =~ $regex ]]; then
    echo "Valid Git repository URL."
    # Extract the repository name
    repo_name=$(basename -s .git $repo_url)
    # Clone the repository
    git clone $repo_url
    # Change directory to the cloned repository
    cd $repo_name
    open -a "`ls -dt /Applications/IntelliJ\ IDEA*|head -1`" .
else
    echo "Invalid Git repository URL."
    exit 1
fi


