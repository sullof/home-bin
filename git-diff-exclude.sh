#!/usr/bin/env bash

ref=master
if [[ "$1" != "" ]]; then ref=$1; fi

exclude=dist
if [[ "$2" != "" ]]; then exclude="$2"; fi

git diff $ref -- . ":(exclude)$exclude"


