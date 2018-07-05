#!/usr/bin/env bash

git init
git add -A
git commit -m "First commit"
git remote add origin "git@github.com:sullof/$1.git"
git push -u origin master
