#!/bin/bash

# This amend and push

branch=$(git rev-parse --abbrev-ref HEAD)
git add -A
git commit --amend
git push -f origin $branch

