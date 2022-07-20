#!/usr/bin/env bash

echo "
This is an example:

  find . -name \"*Test.js\" -exec rename 's/Test.js$/.test.js/' '{}' \;
"
