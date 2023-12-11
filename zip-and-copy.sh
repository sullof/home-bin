#!/bin/bash

# Destination directory for the compressed folders
DESTINATION_DIR="$1"

if [ "$DESTINATION_DIR" == "" ]; then
	echo "Destination directory not specified. Exiting..."
	exit 1
fi

if [ ! -d "$DESTINATION_DIR" ]; then
    mkdir -p "$DESTINATION_DIR"
fi

# Loop through each subfolder in the current directory
for DIR in */; do
    if [ -d "${DIR}" ]; then
        # Remove trailing slash
        DIR_NAME=$(basename "${DIR}")
        if [ "$DIR_NAME" == "Temp" ]; then
			continue
		fi
		echo "Zipping $DIR_NAME..."
        tar -czf "$DESTINATION_DIR/${DIR_NAME}.tar.gz" "${DIR_NAME}"
    fi
done

echo "Compression and copying completed."
