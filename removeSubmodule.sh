#!/usr/bin/env bash


if [[ "$1" == "" ]]; then

	echo "List of existing submodules:"
	git config --file .gitmodules --get-regexp path | awk '{ print $2 }'

	echo "
To remove one, call:
removeSubmodule.sh [submodulePath]"
else

	git submodule deinit -f -- $1
	rm -rf .git/modules/$1
	git rm -f $1

fi
