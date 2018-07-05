#!/bin/bash

git add -A
export SKIP=1 && git commit -m "$1"
git push

