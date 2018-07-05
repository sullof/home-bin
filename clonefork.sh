#!/bin/bash
(
	cd ~/Projects/Forks
	git clone git@github.com:sullof/$1.git
	cd $1
	mergeUpstream.sh $2
	if [[ "$3" == "js" ]]; then
		yarn
	fi
)
