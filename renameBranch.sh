#!/bin/bash

branch=$(echo "$1" | perl -ne 'print lc')
branch2=$(echo "$2" | perl -ne 'print lc')

if [ "$branch" == "master" ]
then
        echo "You cannot rename the master branch."
elif [ "$branch2" == "master" ]
then
        echo "You cannot rename a branch to master."
else
	git branch -m $1 $2
	git push origin :$1
	git push origin $2
fi
