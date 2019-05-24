#!/bin/bash
(
	cd ~/Projects/Repos &&
	git clone git@github.com:$1/$2.git &&
	cd $2 &&
	if [[ -f "package.json" ]]; then
		if [[ -f "package-lock.json" ]]; then
			npm i
		else
			yarn
		fi
	fi
)
