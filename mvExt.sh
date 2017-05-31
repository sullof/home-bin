#!/bin/bash

find . -name "*.es6" -exec bash -c 'mv "$1" "${1%.es6}".js' - '{}' \;
