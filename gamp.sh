#!/bin/bash

NOVERIFY=""

if [[ "$2" == "--skip" ]]; then
	NOVERIFY="--no-verify"
fi

MESSAGE=$1
if [[ "$1" == "" ]]; then
	MESSAGE="No message :-/"
fi

branch=$(git rev-parse --abbrev-ref HEAD)
git add -A
git commit $NOVERIFY -m "$MESSAGE"
git push origin $branch

