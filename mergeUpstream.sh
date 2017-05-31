#!/bin/bash

# This update master with the upstream master and merge master with the current branch.
# If the current branch is master a few commands do nothing.

function merge {
	branch=$(git rev-parse --abbrev-ref HEAD)
	git fetch upstream
	git checkout master
	git merge upstream/master
	git push origin master
	git checkout $branch
	git merge master
}

function add {
	git remote add upstream $1
}

if [[ -n $1 ]]; then
	repo=$(git config --get remote.origin.url | sed -e 's/:[a-zA-Z0-9]*/:'$1'/')
	add $repo
else
	upstream=`git remote -v | grep upstream`
	if [[ -n $upstream ]]; then
		merge
	else
		echo 'No upstream is configured'
	fi
fi
