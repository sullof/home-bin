#!/bin/bash
find ~/Projects -type d -name 'node_modules' -prune -o -type d -name "*$1*" -print
