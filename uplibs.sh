#!/usr/bin/env bash

	if [[ -d "./node_modules/child-process-promise" ]]; then
		echo 'child-process-promise is already installed'
	else
		npm install child-process-promise
	fi
	node ~/bin/_uplibs.js
