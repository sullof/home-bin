#!/usr/bin/env bash

git tag -a "$1" -m "Version $1"
git push origin "$1"



