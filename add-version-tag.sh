#!/usr/bin/env bash

git tag -a "v$1" -m "Version v$1"
git push origin "v$1"



