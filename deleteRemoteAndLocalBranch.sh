#!/bin/bash

branch=$(echo "$1" | perl -ne 'print lc')

if [[ "$branch" == "master" || "$branch" == "main"]]
then
	echo "You cannot delete the master/main branch."
else
	git branch -D $1
	git push origin --delete $1
fi
