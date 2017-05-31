#!/usr/bin/env bash
(
	cd ~/bin

	if [[ -d "./node_modules/child-process-promise" ]]; then
		echo 'child-process-promise is already installed'
	else
		npm install child-process-promise
	fi

	pids=`node ~/bin/_killSpotify.js`

	kill -9 $pids

)
