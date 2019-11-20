#!/bin/bash

help () {
  echo "
ERROR: Invalid option.

Accepted options:
    -r [repo name]
    -u [upstream user name] (optional)
Example:
    clonefork.sh -r truffle -u trufflesuite
"
}

while getopts "r:u:" opt; do
  case $opt in
    r)
      REPO=$OPTARG
      ;;
    u)
      UPSTREAM=$OPTARG
      ;;
    \?)
      help
      exit 1
      ;;
  esac
done

if [[ "$REPO" == "" ]]; then
  help
  exit 1
fi

(
	cd ~/Projects/Forks
	git clone git@github.com:sullof/$REPO.git
	cd $REPO
	if [[ "$UPSTREAM" != "" ]]; then
		mergeUpstream.sh $UPSTREAM
	fi
	if [[ -f "package.json" ]]; then
		if [[ -f "yarn.lock" ]]; then
			yarn
		else
			npm i
		fi
	fi
)
