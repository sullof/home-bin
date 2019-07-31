#!/bin/bash

while getopts "or:u:" opt; do
  case $opt in
    r)
      REPO=$OPTARG
      ;;
    u)
      UPSTREAM=$OPTARG
      ;;
    \?)
      echo "
ERROR: Invalid option.

Accepted options:
    -r [repo name]
    -u [upstream user name]
Example:
    clonefork.sh -r truffle -u trufflesuite
"
      exit 1
      ;;
  esac
done

(
	cd ~/Projects/Forks
	git clone git@github.com:sullof/$REPO.git
	cd $REPO
	if [[ "$UPSTREAM" != "" ]]; then
		mergeUpstream.sh $UPSTREAM
	fi
	if [[ -f "package.json" ]]; then
		if [[ -f "package-lock.json" ]]; then
			npm i
		else
			yarn
		fi
	fi
)
