#!/usr/bin/env bash

if [[ "$4" == "" ]]; then
	echo "
Example:

useradd.sh sullof "Francesco Sullo" 1002 "my password"

"
else
	sudo dscl . -create /Users/$1 UserShell /bin/bash
	sudo dscl . -create /Users/$1 RealName "$2"
	sudo dscl . -create /Users/$1 UniqueID $3
	sudo dscl . -create /Users/$1 PrimaryGroupID 1000
	sudo dscl . -create /Users/$1 NFSHomeDirectory /Local/Users/$1
	sudo dscl . -passwd /Users/$1 $4
fi
