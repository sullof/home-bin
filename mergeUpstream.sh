#!/bin/bash

help () {
  echo "
ERROR: Invalid option.

Accepted options:
    -u [upstream organization]    (accepted only if the upstream is not set)
Example:
    mergeUpstream.sh
    mergeUpstream.sh -u someorg
"
}

while getopts "u:" opt; do
  case $opt in
    u)
      upstreamUrl=$OPTARG
      ;;
    \?)
      help
      exit 1
      ;;
  esac
done

function merge {
	branch=$(git rev-parse --abbrev-ref HEAD)
	git fetch upstream
	git merge upstream/$branch
}

if [[ $upstreamUrl != "" ]]; then
	repo=$(git config --get remote.origin.url | sed -e 's/:[a-zA-Z0-9]*/:'$upstreamUrl'/')
	git remote add upstream $repo
else
	upstream=`git remote -v | grep upstream`
	if [[ -n $upstream ]]; then
		branch=$(git rev-parse --abbrev-ref HEAD)
		git fetch upstream
		git merge upstream/$branch
	else
		echo 'No upstream is configured'
	fi
fi
