#!/bin/bash
(
cd ~/Projects &&
git clone git@git.corp.yahoo.com:$1/$2.git &&
cd $2 &&
ynpm install
)