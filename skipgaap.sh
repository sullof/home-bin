#!/bin/bash

# This amend and push

git add -A
export SKIP=1 && git commit --amend --no-edit
git push -f

