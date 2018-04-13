#!/usr/bin/env bash

if [[ -n $1 ]]; then
	repo=$(git config --get remote.origin.url | sed -e 's/:[a-zA-Z0-9]*/:'$1'/')
	echo "git remote set-url origin $repo"
fi

