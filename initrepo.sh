#!/bin/bash


help () {
  echo "
ERROR: Invalid option.

Accepted options:
    -o [organization] (optional)
    -r [repo name]
Example:
    initrepo.sh -r dapp -o tweedentity
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
	cd ~/Projects/Personal/$REPO
	git init
	git add -A
	git commit -m "first commit"
	git branch -M master
	git remote add origin git@github.com:$ORG/$REPO.git
	git push -u origin master

	echo "~/Projects/Repos/$REPO" | clipboard
	echo "$REPO initialized"
)
