#!/usr/bin/env bash

if [[ $1 = "" ]];then
	echo "You must specify origin and PR number"
elif [[ $2 = "" ]];then
	git ls-remote --refs $1
else
	git fetch $1 pull/$2/head:pr/$2 && git checkout pr/$2
fi

