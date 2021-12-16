#!/bin/bash

git fetch origin pull/7/head:$1
git checkout $1
