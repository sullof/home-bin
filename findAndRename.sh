#!/usr/bin/env bash

#this is an example
find . -name "*Test.js" -exec rename 's/Test.js$/.test.js/' '{}' \;
