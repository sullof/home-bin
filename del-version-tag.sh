#!/usr/bin/env bash

git tag -d "v$1"
git push --delete origin "v$1"


