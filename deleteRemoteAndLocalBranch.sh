#!/bin/bash

branch=$(echo "$1" | perl -ne 'print lc')

if [ "$branch" == "master" ]
then
	echo "You cannot delete the master branch."
else
	git branch -D $1
	git push origin --delete $1
fi
