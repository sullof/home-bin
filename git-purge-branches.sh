#!/usr/bin/env bash

branch=`git rev-parse --abbrev-ref HEAD`
git branch | grep -v "master" | grep -v "$branch" | xargs git branch -D
