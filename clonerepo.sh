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
