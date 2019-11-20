#!/bin/bash

USER=$1
REPO=$2
if [[ "$REPO" == "" ]]; then
  REPO=$1
  USER=sullof
fi

(
	cd ~/Projects/Repos
	git clone git@github.com:$USER/$REPO.git
	cd $REPO
	if [[ -f "package.json" ]]; then
		if [[ -f "package-lock.json" ]]; then
			npm i
		else
			yarn
		fi
	fi
)


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
