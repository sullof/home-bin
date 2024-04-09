#!/usr/bin/env bash

git tag -d "$1"
git push --delete origin "$1"


