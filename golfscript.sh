#!/usr/bin/env bash

echo "${@:2}" | ruby ~/bin/golfscript.rb $1
