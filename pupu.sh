#!/bin/bash

# This pulls the current branch skipping the editing and pushes it.

branch=$(git rev-parse --abbrev-ref HEAD)
git pull origin $branch --no-edit && git push
