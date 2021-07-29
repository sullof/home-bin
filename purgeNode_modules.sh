#!/usr/bin/env bash

if [[ -d "node_modules" ]]; then
	echo "Purging node_modules"
	rm -rf node_modules
fi

for file in */ ; do
#	if [[ -d "$file" && ! -L "$file" ]]; then
  		if [[ -d $file"node_modules" ]]; then
  			echo "Purging "$file"node_modules"
    		rm -rf $file"node_modules"
    	fi
#  	fi
done
