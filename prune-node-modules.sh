#!/usr/bin/env bash

if [[ "$1" == "" ]]; then
	find . -name 'node_modules' -type d -prune
else
    find . -name 'node_modules' -type d -prune -exec rm -rf '{}' +
fi
