#!/bin/bash

help () {
  echo "
ERROR: Invalid option.

Accepted options:
    -r [repo name]
    -u [upstream user name] (optional)
Example:
    clonefork.sh -r truffle -u trufflesuite
    clonefork.sh trufflesuite/truffle
"
}

text=$1
IFS='/'
read -a strarr <<< "$text"
for val in "${strarr[@]}";
do
  if [[ "$UPSTREAM" == "" ]]; then
  	UPSTREAM=$val
  else
  	REPO=$val
  fi
done

if [[ "$REPO" == "" || "$UPSTREAM" == "" ]]; then
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
fi

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
		elif [[ -f "pnpm-lock.yaml" ]]; then
			pnpm i
		else
			npm i
		fi
	fi

	echo "~/Projects/Forks/$REPO" | clipboard

)
