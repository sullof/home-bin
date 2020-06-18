#!/bin/bash

help () {
  echo "
ERROR: Invalid option.

Accepted options:
    -r [repo name]
    -o [organization] (optional)
Example:
    clonerepo.sh -r truffle -o trufflesuite
"
}

text=$1
IFS='/'
read -a strarr <<< "$text"
for val in "${strarr[@]}";
do
  if [[ "$ORG" == "" ]]; then
  	ORG=$val
  else
  	REPO=$val
  fi
done

if [[ "$REPO" == "" || "$ORG" == "" ]]; then
	ORG=sullof
	while getopts "r:o:" opt; do
	  case $opt in
		r)
		  REPO=$OPTARG
		  ;;
		o)
		  ORG=$OPTARG
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
	cd ~/Projects/Repos
	git clone git@github.com:$ORG/$REPO.git
	cd $REPO
	if [[ -f "package.json" ]]; then
		if [[ -f "yarn.lock" ]]; then
			yarn
		else
			npm i
		fi
	fi
)
