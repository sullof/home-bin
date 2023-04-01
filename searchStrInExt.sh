#!/bin/sh

find . -type f -name "*.$2" ! -path "*/node_modules/*" -exec grep -l "$1" {} +
