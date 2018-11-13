#!/bin/bash
(
	cd ~/Projects/Forks
	git clone git@github.com:sullof/$1.git
	cd $1
	if [[ "$2" != "" ]]; then
		mergeUpstream.sh $2
	fi
	if [[ -f "package.json" ]]; then
		if [[ -f "package-lock.json" ]]; then
			npm i
		else
			yarn
		fi
	fi
)
