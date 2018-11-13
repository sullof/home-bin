#!/bin/bash
(
cd ~/Projects/Repos &&
git clone git@github.com:$1/$2.git &&
cd $2 &&
yarn
)
