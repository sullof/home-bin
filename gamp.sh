#!/bin/bash

NOVERIFY=""

if [[ "$2" == "--skip" ]]; then
	NOVERIFY="--no-verify"
fi

branch=$(git rev-parse --abbrev-ref HEAD)
git add -A
git commit $NOVERIFY -m "$1"
git push origin $branch

