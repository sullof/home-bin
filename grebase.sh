#!/usr/bin/env bash

branch=`git rev-parse --abbrev-ref HEAD`

if [ $branch == "master" ]
then
	echo "Error: You can't run this on master."
	exit 1
fi

log=`git log --oneline`
IFS=$'\n' read -d '' -r -a arr <<< "$log"
str='Merge pull request #'
count=0
for i in "${arr[@]}"
do
	if [[ "$i" == *" Merge pull request #"* || "$i" == *" Update version to "* ]]; then
   		break
	fi
	count=$((count+1))
done

if [[ $count < 2 ]]; then
	echo 'Error: There are no commits to rebase.'
	exit
else
	echo 'Ready to rebase '$count' commits.'
fi

if [[ -z $1 ]];then
	echo 'Error: A commit rebase message is required.'
	exit
fi

if [[ ! -z $3 ]];then
	count=$3
fi

git reset --soft HEAD~$count
git commit -m "$1"

if [[ $2 == 'push' ]];then
	git push -f
fi

echo 'Done!'
