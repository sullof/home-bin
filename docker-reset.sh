#!/bin/bash

read -r -p "This will remove any container and image. Are you sure? [y/n] " response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    docker rm -f $(docker ps -a -q) && docker rmi -f $(docker images -q)
else
	echo "Reset canceled."
fi
